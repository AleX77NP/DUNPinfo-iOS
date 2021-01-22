//
//  ExamsDep.swift
//  DUNP-info
//
//  Created by Aleksandar on 31/12/2020.
//

import Foundation
import SwiftUI

struct ExamsDep : View {
    
    @ObservedObject var examsFetcher = ExamsFecther()
    
    var body: some View {
        VStack{
        NavigationView{
            if examsFetcher.examsDeps.isEmpty {
                Text("Lista departmana trenutno nije dostupna").navigationTitle("Departmani")
            }
            
        List(self.examsFetcher.examsDeps) { dep in
            ExamsDepItem(dep: dep)
        }.accentColor(.clear)
        .navigationTitle("Departmani")
        .listStyle(InsetListStyle())
        }.navigationViewStyle(StackNavigationViewStyle())
      }
    }
}
