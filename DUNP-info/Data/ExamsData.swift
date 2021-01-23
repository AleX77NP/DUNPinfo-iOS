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

struct Predmet: Decodable, Hashable, Encodable, Identifiable {
    let id: Int
}

struct ExamInfo: Decodable, Hashable, Encodable, Identifiable {
    let id: Int
    let ispitnirok_set: [IspitniRok]
}

struct IspitniRok: Decodable, Hashable, Encodable, Identifiable {
    let id: Int
    let godina: Int
    let ispitni_rok: String
    let slika: String
    let proveren: Bool
    let predmet: Int
}

class ExamsFecther: ObservableObject {
    
    @Published var examsDeps = [DUNPdep]()

    func fetchDUNPdeps() -> Void {
        let depUrl = "http:/68.66.242.98/api/faks/departman/"
        let url = URL(string: depUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        URLSession.shared.self.dataTask(with: url!) {
            (data, response, error) in
            if data != nil && error == nil {
            do {
                let temp = try JSONDecoder().self.decode([DUNPdep].self, from: data!)
                DispatchQueue.main.async {
                    self.examsDeps = temp
                }
            }
            catch {
                print(error)
            }
            } else {
                return
            }
        }.resume()
        
    }
    
    init() {
        fetchDUNPdeps()
    }
}

class IRFetcher: ObservableObject {
    @Published var rok = ExamInfo(id: 1, ispitnirok_set: [])
    let idP: Int
    
    init(id: Int) {
        self.idP = id
        fetchIR()
    }
    
    func fetchIR() -> Void {
        let depUrl = "http://68.66.242.98/api/faks/predmet/" + String(idP) + "/"
        let url = URL(string: depUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        

        URLSession.shared.self.dataTask(with: url!) {
            (data, response, error) in
            if data != nil && error == nil {
            do {
                let temp = try JSONDecoder().self.decode(ExamInfo.self, from: data!)
                DispatchQueue.main.async {
                    self.rok = temp
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
}

