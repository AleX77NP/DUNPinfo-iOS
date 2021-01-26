//
//  IRItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 10/01/2021.
//

import Foundation
import SwiftUI

struct IRItem: View {
    
    var rok: String
    var godina: Int
    var slika: String
    
    var body: some View {
        NavigationLink(destination: ExamImage(slika: slika)){
            HStack{
            Text(rok + " " + String(godina))
                .font(Font.custom("Roboto",fixedSize: 14)).padding().foregroundColor(.blue)
                Spacer()
            }.border(Color.gray, width: 2)
        }.buttonStyle(PlainButtonStyle()).accentColor(Color.clear)
  }
}

