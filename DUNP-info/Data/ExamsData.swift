//
//  ExamsData.swift
//  DUNP-info
//
//  Created by Aleksandar on 14/12/2020.
//

import Foundation


struct DUNPdep: Decodable, Hashable, Encodable, Identifiable {
    let id: Int
    let naziv: String
    let smer_set: [DUNPSmer]
}

struct DUNPSmer: Decodable, Hashable, Encodable, Identifiable {
    let id: Int
    let naziv: String
    let smerpredmet_set: [SmerPredmet]
}

struct SmerPredmet: Decodable, Hashable, Encodable, Identifiable {
    let id: Int
    let naziv_predmeta: String
    let godina_studija: Int
    let smer: Int
    let predmet: Int
}

struct Predmet {
    let id: Int
}

class ExamsFecther: ObservableObject {
    
    @Published var examsDeps = [DUNPdep]()
    
    func fetchDUNPdeps() -> Void {
        let depUrl = "http://185.143.45.132/api/faks/departman"
        let url = URL(string: depUrl)
        
        URLSession.shared.self.dataTask(with: url!) {
            (data, response, error) in
            do {
                let temp = try JSONDecoder().self.decode([DUNPdep].self, from: data!)
                DispatchQueue.main.async {
                    print(temp)
                    self.examsDeps = temp
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    init() {
        fetchDUNPdeps()
    }
}
