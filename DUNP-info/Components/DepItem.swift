//
//  DepItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 02/12/2020.
//

import Foundation
import SwiftUI

struct DepItem: View {
    var item: Department
    
    var body: some View {
        HStack{
            Text(item.name)
               // .shadow(color: Color(hex: 0x5400cb), radius: 0.2)
                .font(Font.custom("Roboto",fixedSize: 14)).padding()
            Spacer()
        }
        .border(Color.gray, width: 2)
  }
}

