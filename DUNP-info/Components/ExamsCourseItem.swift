//
//  ExamsCourseItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 31/12/2020.
//

import Foundation
import SwiftUI

struct ExamsCourseItem: View {
    
    var smer: DUNPSmer
    
    var body: some View {
        NavigationLink(destination: ExamsSubjects(predmeti: smer.smerpredmet_set)){
            HStack{
            Text(smer.naziv)
                .font(Font.custom("Roboto",fixedSize: 14)).padding().foregroundColor(.blue)
                Spacer()
            }.border(Color.gray, width: 2)
    }.buttonStyle(PlainButtonStyle()).accentColor(Color.clear)
  }
}
