//
//  News.swift
//  DUNP-info
//
//  Created by Aleksandar on 16/11/2020.
//

import Foundation
import SwiftUI
import SwiftUIRefresh

struct News : View {
    @ObservedObject var fetcher: NewsUpdater = .sharedNews
    @State var loading = false;
    @State var text = ""
    @State var isOpen = false;
    @State var refresh = false;
    
    var lista: [NewsColor] = [
        NewsColor(tip: "obavestenja", boja: Color.orange),
        NewsColor(tip: "obavestenja smera", boja: Color.purple),
        NewsColor(tip: "raspored ispita", boja: Color.blue),
        NewsColor(tip: "raspored predavanja", boja: Color.gray),
        NewsColor(tip: "termini konsultacija", boja: Color.green),
        NewsColor(tip: "vesti", boja: Color.red),
        NewsColor(tip: "instagram", boja: Color.pink),
    ]
    
    func fetchNews(isFirst: Bool) -> Void {
        if isFirst {
        self.loading = true
        }
        let mojUrl = formirajURL(id: getLatestId())
        print(mojUrl)
        let finalURL = mojUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard
          let url = URL(string: finalURL!)
          else { return }
                URLSession.shared.self.dataTask(with: url) {
                    (data, response, error) in
                        if data != nil && error == nil {
                        do {
                        let temp = try JSONDecoder().self.decode([NewsItem].self, from: data!)
                        DispatchQueue.main.async {
                            saveMyNews(news: temp)
                            let latest_ID = temp.map { $0.pk}.max()
                            if latest_ID != nil {
                                setLatestId(id: latest_ID!)
                            } else {
                                print("No new latest id")
                            }
                            if isFirst {
                            self.loading = false
                            }
                            self.fetcher.newNews = getMyNews()
                            self.refresh = false
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                        if isFirst {
                        self.loading = false
                        }
                        self.refresh = false
                        
                }
                 } else {
                    return
              }
            
          }.resume()
       }
    
    init() {
        print(getLatestId())
        fetchNews(isFirst: true)
    }
    
    var body: some View {
        NavigationView{
            if (self.loading) {
                ProgressView().navigationTitle("Novosti")
            }
            else if(fetcher.newNews.isEmpty) {
                Text("Lista novosti je prazna.").font(Font.custom("Ubuntu", fixedSize: 18)).navigationTitle("Novosti")
                }
        else {
        List {
            NewsSearchBar(text: $text)
            ForEach(fetcher.newNews.filter {self.text.isEmpty ? true : $0.fields.naslov.lowercased().contains(text.lowercased())}, id: \.self) { novelty in
                NewsListItem(item: novelty, color: lista.first(where: {$0.tip == novelty.fields.tip})!.boja)
            }
        }.pullToRefresh(isShowing: $refresh, onRefresh: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    fetchNews(isFirst: false)
            }
        })
        .listStyle(InsetListStyle())
        .navigationTitle("Novosti")
        .navigationBarItems(trailing:
            HStack{
            Text("Filter")
            Image("filters").resizable().frame(width: 12, height: 12)
            }.onTapGesture {
            self.isOpen.toggle()
        }
       )
      }
        }.navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isOpen, content: {
        FilterModal(isPresented: $isOpen, chosenType: {
            tip in
            if (tip == "sve novosti") {
            self.fetcher.newNews = getMyNews()
            } else {
            self.fetcher.newNews = getMyNews()
            self.fetcher.newNews = self.fetcher.newNews.filter {$0.fields.tip == tip}
            }
        })
      })
    }
  }



struct NewsColor {
    var tip: String
    var boja: Color
}



