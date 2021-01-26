//
//  ThirdTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 11/11/2020.
//

import Foundation
import SwiftUI

struct ThirdTutorial: View {
    @ObservedObject var depSettings: departmentsChanged = .sharedDeps
    @ObservedObject var fetcher: NewsUpdater = .sharedNews
    @ObservedObject var settings: finishedTutorial = .shared
    
    var deps: [Department] = getAllDepartments()
    init() {
       // print("departmani")

    }
    var body: some View{
        
        VStack {
            Text("Izaberi svoj departman")
                .font(Font.custom("Ubuntu", fixedSize: 24))
                .bold()
                .padding(self.settings.isOver ? .vertical : .bottom)
              //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
            Text("Možete dodati i više departmana u okviru kojih ćete izabrati smerove za koje želite da primate vesti i obaveštenja.").font(Font.custom("Roboto", size: 16)).padding().frame(width: UIScreen.main.bounds.width*0.90).foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.primary, lineWidth: 2)
                ).background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: 0x5400cb)))
            
            
            List(deps) { dep in
                if self.depSettings.deps.contains(dep){
                Button(action: {
                    if !self.depSettings.deps.contains(dep) {
                    self.depSettings.deps.append(dep)
                        saveDepartments(myDeps: self.depSettings.deps)
                        if(self.settings.isOver) {
                            fetchNewsOnChange(fetcher: self.fetcher)
                            changeStudentInfo()
                        }
                    }
                    else {
                        self.depSettings.deps =  self.depSettings.deps.filter { $0 != dep }
                        saveDepartments(myDeps: self.depSettings.deps)
                        removeDepCourses(dep: dep)
                        if(self.settings.isOver) {
                            fetchNewsOnChange(fetcher: self.fetcher)
                            changeStudentInfo()
                        }
                    }
                }) {
                DepItemSelected(item: dep)
            }
         }
                else {
                    Button(action: {
                        if !self.depSettings.deps.contains(dep) {
                        self.depSettings.deps.append(dep)
                            saveDepartments(myDeps: self.depSettings.deps)
                            if(self.settings.isOver) {
                                fetchNewsOnChange(fetcher: self.fetcher)
                                changeStudentInfo()
                            }
                        }
                        else {
                            self.depSettings.deps =  self.depSettings.deps.filter { $0 != dep }
                            saveDepartments(myDeps: self.depSettings.deps)
                            removeDepCourses(dep: dep)
                            if(self.settings.isOver) {
                                fetchNewsOnChange(fetcher: self.fetcher)
                                changeStudentInfo()
                            }
                        }
                    }) {
                    DepItem(item: dep)
                  }
                 }
                
            }.listStyle(InsetListStyle()).navigationTitle("").navigationBarTitleDisplayMode(.inline)
            .accentColor(.clear)
        }
    }
}
