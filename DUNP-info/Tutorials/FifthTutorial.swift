//
//  FifthTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 13/11/2020.
//

import Foundation
import SwiftUI
import Firebase

struct FifthTutorial: View {
    
    @ObservedObject var sviTipovi = ListVesti()
    @ObservedObject var subs : subsChanged = .subsC
    @ObservedObject var fetcher: NewsUpdater = .sharedNews
    @ObservedObject var settings: finishedTutorial = .shared
    
    init() {
        print(vratiPretplate())
        sviTipovi.tipovi =  sviTipovi.tipovi.map{ (vest : Vest) -> Vest  in
            var mutable  = vest
            if(subs.subs.contains(mutable.naziv)) {
                mutable.change()
            }
            return mutable
        }
    }
    
    
    var body: some View {
        
        VStack {
            Text("Za šta želite da dobijate novosti?")
                .font(Font.custom("Ubuntu", fixedSize: 24))
                .bold()
                .padding(self.settings.isOver ? .vertical : .bottom)
              //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
            
            List {
                ForEach(0..<sviTipovi.tipovi.count, id: \.self) { index in
                    HStack {
                        Text(sviTipovi.tipovi[index].naziv.capitalizingFirstLetter().replacingOccurrences(of: "bavestenja", with:"baveštenja")).font(Font.custom("Roboto", size: 18))
                        Spacer()
                        Toggle("",isOn: $sviTipovi.tipovi[index].enabled).onTapGesture {
                            if(!sviTipovi.tipovi[index].enabled) {
                                subs.subs.append(sviTipovi.tipovi[index].naziv)
                                podesiPretplate(pretplate: subs.subs)
                                print(vratiPretplate())
                                if(self.settings.isOver) {
                                    fetchNewsOnChange(fetcher: self.fetcher)
                                    changeStudentInfo()
                                }
                            } else {
                                subs.subs = subs.subs.filter { $0 != sviTipovi.tipovi[index].naziv}
                                podesiPretplate(pretplate: subs.subs)
                                print(vratiPretplate())
                                if(self.settings.isOver) {
                                    fetchNewsOnChange(fetcher: self.fetcher)
                                    changeStudentInfo()
                                }
                            }
                        }
                    }.padding()
                }
                
            }.navigationTitle("").navigationBarTitleDisplayMode(.inline)
        }.ignoresSafeArea(.keyboard)
    }
}


struct Vest {
    var naziv: String
    var enabled: Bool = false
}

class ListVesti: ObservableObject {
    @Published var tipovi: [Vest] = [
        Vest(naziv: "vesti"),
        Vest(naziv: "obavestenja"),
        Vest(naziv: "obavestenja smera"),
        Vest(naziv: "raspored ispita"),
        Vest(naziv: "raspored predavanja"),
        Vest(naziv: "termini konsultacija"),
        Vest(naziv: "instagram")
        ]
}

extension Vest {
    mutating func change(){
        self.enabled.toggle()
   }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
