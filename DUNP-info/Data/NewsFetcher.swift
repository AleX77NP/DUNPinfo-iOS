//
//  NewsFetcher.swift
//  DUNP-info
//
//  Created by Aleksandar on 16/11/2020.
//

import Foundation
import SwiftUI

class NewsUpdater: ObservableObject {
    private init() {}
    static let sharedNews = NewsUpdater()
    @Published var newNews = getMyNews()
}

struct NewsItem: Decodable, Hashable, Encodable {
    let model: String
    let pk: Int
    let fields: Novelty
    
    
}

struct Novelty: Decodable, Hashable, Encodable {
    let tip: String
    let naslov: String
    let link: String
    let opis: String
    let hash_value: String
    let datum: String
}

func setLatestId(id: Int) -> Void { // postavlja id zadnje nove fetchovane novosti //
    UserDefaults.standard.setValue(id, forKey: "latest_id")
}

func getLatestId() -> Int { // vraca zadnji id, da se zna odakle da se fetchuje sledeci put //
    var myId = 0;
    if let l_id = UserDefaults.standard.value(forKey: "latest_id") {
        myId = l_id as! Int
    }
    return myId
}


func saveMyNews(news: [NewsItem]) -> Void { // cuva vesti u User Defaults
    var oldNews: [NewsItem] = []
    if let myNews = UserDefaults.standard.value(forKey: "news") as? Data {
        oldNews = try! JSONDecoder().decode([NewsItem].self, from: myNews)
        let novosti = concatNews(old: oldNews, newOnes: news)
        saveNewsJSON(news: novosti)
    } else {
        saveNewsJSON(news: news)
    }
    
}

func getMyNews() -> [NewsItem] { // vraca sve vesti korisnika
    var myNews: [NewsItem] = []
    if let novosti = UserDefaults.standard.value(forKey: "news") as? Data {
        myNews = try! JSONDecoder().decode([NewsItem].self, from: novosti)
    }
    return myNews
}

func concatNews(old: [NewsItem], newOnes: [NewsItem]) -> [NewsItem] {  // uzima nove vesti i spaja sa starim vestima //
    let uniqueNews = Array(Set(old + newOnes)).sorted {$0.pk > $1.pk} // ne smeju postojati 2 iste vesti //
    return uniqueNews
}

func saveNewsJSON(news: [NewsItem]) -> Void {
    let myNews = try! JSONEncoder().encode(news)
    UserDefaults.standard.setValue(myNews, forKey: "news")
}

func emptyNews() -> Void {
    let news: [NewsItem] = []
    let myNews = try! JSONEncoder().encode(news)
    UserDefaults.standard.setValue(myNews, forKey: "news")
}

func changesMade() -> Void {
    setLatestId(id: 0)
    emptyNews()
}

func fetchNewsOnChange(fetcher: NewsUpdater) -> Void {
    print("fetch on change starts")
    changesMade()
    let mojUrl = formirajURL(id: getLatestId())
    let finalURL = mojUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    guard
      let url = URL(string: finalURL!)
      else { return }
            URLSession.shared.self.dataTask(with: url) {
                (data, response, error) in
                if error == nil && data != nil {
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
                        fetcher.newNews = getMyNews()
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                } else {
                    return
                }
        }.resume()
}
