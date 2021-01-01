//
//  DepItemSelected.swift
//  DUNP-info
//
//  Created by Aleksandar on 02/12/2020.
//

import Foundation
import SwiftUI

struct DepItemSelected: View {
    var item: Department
    
    var body: some View {
        HStack{
        Text(item.name)
           // .shadow(color: Color(hex: 0x02b9b5), radius: 0.2)
            .foregroundColor(Color(hex: 0x02b9b5))
            .font(Font.custom("Roboto",fixedSize: 14))
            .padding()
        
            Spacer()
            Image("check")
                .foregroundColor(Color(hex: 0x02b9b5)).padding()
      }
        .border(Color(hex: 0x02b9b5), width: 2)
    }
}
