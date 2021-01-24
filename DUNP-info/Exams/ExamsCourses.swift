//
//  ExamsCourses.swift
//  DUNP-info
//
//  Created by Aleksandar on 31/12/2020.
//

import Foundation
import SwiftUI

struct ExamsCourses: View {
    
    var smerovi: [DUNPSmer]
    
    var body: some View {
        VStack{
        List(self.smerovi) { smer in
            ExamsCourseItem(smer: smer)
        }.accentColor(Color(UIColor.systemBackground))
        .navigationTitle("Smerovi")
        .listStyle(InsetListStyle())
            
       }
    }
}
