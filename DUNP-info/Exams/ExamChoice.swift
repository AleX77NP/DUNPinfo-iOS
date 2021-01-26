//
//  ExamChoice.swift
//  DUNP-info
//
//  Created by Aleksandar on 11/01/2021.
//

import Foundation
import SwiftUI

struct ExamChoice: View {
    @ObservedObject var examsFetcher = ExamsFecther()
    
    @State var isActive = false
    
    @ObservedObject var depSettings: departmentsChanged = .sharedDeps
    
    var rokovi : [String] = [
        "Januar",
        "Februar",
        "Mart",
        "April",
        "Maj",
        "Jun",
        "Jul",
        "Avgust",
        "Septembar",
        "Oktobar",
        "Oktobar2",
        "Novembar",
        "Decembar"
    ]
    
    @State private var selection = 0
    @State private var selectionC = 0
    @State private var selectionP = 0
    @State private var selectionR = "Januar"
    @State private var selectionG = 2006
    @State private var nazivP = ""
    
    @State private var showAlert = false
    let year = Calendar.current.component(.year, from: Date())
    
    func mojiDep(depId: Int) -> Bool {
        let ids = depSettings.deps.map{$0.id}
        return ids.contains(depId) ? true : false
    }
    
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                Picker(selection: $selection, label: Text("Departman")) {
                    ForEach(examsFetcher.examsDeps) { dep in
                        if mojiDep(depId: dep.id) {
                        Text(dep.naziv).id(dep.id)
                        }
                    }
                 }.onChange(of: selection) { _ in
                    print(selection)
                }
                Picker(selection: $selectionC, label: Text("Smer")) {
                    ForEach(examsFetcher.examsDeps.first(where: {$0.id == selection})?.smer_set ?? []) { smer in
                        Text(smer.naziv).id(smer.id)
                    }
                    }.onChange(of: selectionC) { _ in
                        print(selectionC)
                    }
                Picker(selection: $selectionP, label: Text("Predmet")) {
                    ForEach(examsFetcher.examsDeps.first(where: {$0.id == selection})?.smer_set.first(where: {$0.id == selectionC})?.smerpredmet_set ?? [], id: \.self.predmet) { pred in
                        Text(pred.naziv_predmeta).id(pred.predmet)
                    }
                }.onChange(of: selectionP) { _ in
                        print(selectionP)
                    nazivP = examsFetcher.examsDeps.first(where: {$0.id == selection})?.smer_set.first(where: {$0.id == selectionC})?.smerpredmet_set.first(where: {$0.predmet == selectionP})?.naziv_predmeta ?? ""
                    }
                Picker(selection: $selectionR, label: Text("Ispitni rok")) {
                    ForEach(rokovi, id: \.self) { rok in
                        Text(rok).id(rok)
                    }
                }.onChange(of: selectionR) { _ in
                    print(selectionR)
                }
                    Picker(selection: $selectionG, label: Text("Godina")){
                        ForEach(2006 ..< year+1, id: \.self) { god in
                            Text(String(god)).id(god)
                        }
                 }.onChange(of: selectionG) { _ in
                    print(selectionG)
                }
                        HStack{
                            Spacer()
                    Button(action: {
                        if (selectionC == 0 || selectionP == 0) {
                            print("greska")
                            showAlert = true
                        } else {
                        isActive.toggle()
                        }
                    }) {
                        HStack{
                        Text("NAPRED")
                            .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                            .foregroundColor(Color(hex: 0x5400cb))
                            Image("arrow_right")
                                .foregroundColor(Color(hex: 0x5400cb))
                        }
                    }.padding().frame(height:40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: 0x5400cb), lineWidth: 2))
                            
                            NavigationLink (destination: ExamUpload(rootIsActive: $isActive,predmet: selectionP, godina: selectionG, rok: selectionR, nazivPr: nazivP), isActive: $isActive){}.hidden().frame(width:0).disabled(!isActive)
                            
                    }.padding([.top,.leading,.bottom])
            
              }
                
            }.navigationTitle("Dodaj ispitni rok").foregroundColor(.blue).navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle()).alert(isPresented: $showAlert) {
            Alert(title: Text("Podaci"), message: Text("Morate odabrati predmet kako biste nastavili dalje."))
      }
    }
}
