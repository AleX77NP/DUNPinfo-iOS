//
//  News.swift
//  DUNP-info
//
//  Created by Aleksandar on 16/11/2020.
//

import Foundation
import SwiftUI
import UIKit

struct News : View {
    @ObservedObject var fetcher: NewsUpdater = .sharedNews
    @State var loading = false;
    @State var text = ""
    @State var isOpen = false;
    
    var lista: [NewsColor] = [
        NewsColor(tip: "obavestenja", boja: Color.orange),
        NewsColor(tip: "obavestenja smera", boja: Color.purple),
        NewsColor(tip: "raspored ispita", boja: Color.blue),
        NewsColor(tip: "raspored predavanja", boja: Color.gray),
        NewsColor(tip: "termini konsultacija", boja: Color.green),
        NewsColor(tip: "vesti", boja: Color.red),
        NewsColor(tip: "instagram", boja: Color.pink),
    ]
    
    func fetchNews() -> Void {
        self.loading = true
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
                            self.loading = false
                            self.fetcher.newNews = getMyNews()
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                        self.loading = false
                }
                 } else {
                    return
              }
            
            }.resume()
    }
    
    init() {
        print(getLatestId())
        fetchNews()
    }
    
    var body: some View {
        if(self.loading) {
            ProgressView()
        } else {
        if(fetcher.newNews.isEmpty) {
            Text("Lista novosti je prazna.").font(Font.custom("Ubuntu", fixedSize: 18))
            }
        else {
        NavigationView{
        List {
            NewsSearchBar(text: $text)
            ForEach(fetcher.newNews.filter {self.text.isEmpty ? true : $0.fields.naslov.lowercased().contains(text.lowercased())}, id: \.self) { novelty in
                NewsListItem(item: novelty, color: lista.first(where: {$0.tip == novelty.fields.tip})!.boja)
            }
        }.navigationTitle("Novosti")
        .listStyle(InsetListStyle())
        .navigationBarItems(leading: Text("Osveži").onTapGesture {
            self.fetchNews()
        }, trailing:
            HStack{
            Text("Filter")
            Image("filters").resizable().frame(width: 12, height: 12)
            }.onTapGesture {
            self.isOpen.toggle()
        }
       )
     }
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
 }
}

struct NewsColor {
    var tip: String
    var boja: Color
}

struct FilterModal : View {
   
    @Binding var isPresented: Bool
    var chosenType: (String) -> ()
    var pretplate = vratiPretplate()
    
    var lista: [NewsColor] = [
        NewsColor(tip: "sve novosti", boja: Color.primary),
        NewsColor(tip: "obavestenja", boja: Color.orange),
        NewsColor(tip: "obavestenja smera", boja: Color.purple),
        NewsColor(tip: "raspored ispita", boja: Color.blue),
        NewsColor(tip: "raspored predavanja", boja: Color.gray),
        NewsColor(tip: "termini konsultacija", boja: Color.green),
        NewsColor(tip: "vesti", boja: Color.red),
        NewsColor(tip: "instagram", boja: Color.pink),
    ]
    var body: some View {
        VStack {
            HStack{
            Text("Filtriraj po tipu novosti").font(Font.custom("Ubuntu", fixedSize: 22))
                .bold().padding()
            Image("filters").resizable().frame(width: 20, height: 20)
            }
            List{
                ForEach(lista, id:\.self.tip) { elem in
                    if(self.pretplate.contains(elem.tip) || elem.tip == "sve novosti") {
                    HStack {
                        Text(elem.tip.capitalizingFirstLetter().replacingOccurrences(of: "vestenja", with: "veštenja")).font(Font.custom("Roboto", fixedSize: 18))
                            .bold()
                        Spacer()
                        Image(elem.tip == "sve novosti" ? "menu_novosti" : elem.tip == "vesti" ? "novosti" : elem.tip.replacingOccurrences(of: " ", with: "_")).resizable().frame(width: 25, height: 25)
                            .padding().foregroundColor(elem.boja)
                    }.onTapGesture {
                        print("Filterrrr")
                        self.chosenType(.init(elem.tip))
                        self.isPresented.toggle()
                    }
                }
              }
            }.listStyle(GroupedListStyle())
            
            Button(action: {
                self.isPresented.toggle()
            }) {
                Text("Nazad").font(Font.custom("Roboto", fixedSize: 20))
            }.padding()
        }
    }
}


