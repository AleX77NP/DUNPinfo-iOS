//
//  ExamSubjects.swift
//  DUNP-info
//
//  Created by Aleksandar on 31/12/2020.
//

import Foundation
import SwiftUI

struct ExamsSubjects: View {
    
    var predmeti: [SmerPredmet]
    var godine = [1,2,3,4]
    
    var body: some View {
        VStack{
            List(self.godine, id: \.self) { godina in
                Section{
                VStack{
                    HStack{
                    Spacer()
                        Text(String(godina) + ". Godina").frame(alignment: .center).padding().font(Font.custom("Roboto",fixedSize: 18))
                    Spacer()
                    }
                ScrollView{
                ForEach(grupaPredmeta(predmeti: self.predmeti, god: godina), id: \.self) { pred in
                ExamsSubjectItem(predmet: pred)
                }
               }
              }
            }
            }.navigationTitle("Predmeti")
        }
    }
}

func grupaPredmeta(predmeti:[SmerPredmet], god: Int) -> [SmerPredmet]{
    return predmeti.filter{$0.godina_studija == god}
}
