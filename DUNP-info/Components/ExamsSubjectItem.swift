//
//  ExamsSubjectItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 31/12/2020.
//

import Foundation
import SwiftUI

struct ExamsSubjectItem: View {
    
    var predmet: SmerPredmet
    
    var body: some View {
        NavigationLink(destination: Text("Rokovi")){
            HStack{
            Text(predmet.naziv_predmeta)
                .font(Font.custom("Roboto",fixedSize: 16)).padding().foregroundColor(.primary)
                Spacer()
            }.border(Color.gray, width: 2)
    }.buttonStyle(PlainButtonStyle()).accentColor(Color.clear)
  }
}
