//
//  ExamsDepItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 31/12/2020.
//

import Foundation
import SwiftUI

struct ExamsDepItem: View {
    
    var dep: DUNPdep
    
    var body: some View {
        NavigationLink(destination: ExamsCourses(smerovi: dep.smer_set)){
            HStack{
            Text(dep.naziv)
                .font(Font.custom("Roboto",fixedSize: 14)).padding().foregroundColor(.blue)
                Spacer()
            }.border(Color.gray, width: 2)
    }.buttonStyle(PlainButtonStyle()).accentColor(Color.clear)
        
  }
}
