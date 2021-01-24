//
//  FilterModal.swift
//  DUNP-info
//
//  Created by Aleksandar on 24/01/2021.
//

import Foundation
import SwiftUI

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
