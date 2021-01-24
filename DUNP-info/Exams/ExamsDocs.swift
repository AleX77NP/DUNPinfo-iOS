//
//  ExamsDocs.swift
//  DUNP-info
//
//  Created by Aleksandar on 10/01/2021.
//

import Foundation
import SwiftUI

struct ExamsDocs : View {
    
    var idP: Int
    
    @ObservedObject var fetcher: IRFetcher
    
    init(predmet: Int) {
        idP = predmet
        fetcher = IRFetcher(id: idP)
    }
    
    var body: some View {
        if(fetcher.rok.ispitnirok_set.isEmpty) {
            Text("Nema ispitnih rokova za ovaj predmet.").font(Font.custom("Roboto",fixedSize: 18)).padding()
        } else {
            List(fetcher.rok.ispitnirok_set.filter {$0.proveren == true}) {set in
            IRItem(rok: set.ispitni_rok, godina: set.godina, slika: set.slika)
        }.accentColor(Color(UIColor.systemBackground))
            .listStyle(InsetListStyle())
        .navigationTitle("Rokovi")
        }
    }
}
