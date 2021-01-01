//
//  CourseItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 02/12/2020.
//

import Foundation
import SwiftUI

struct CourseItem: View {
    var item: String
    
    var body: some View {
        HStack{
            Text(item)
             //   .shadow(color: Color(hex: 0x5400cb), radius: 0.2)
                .font(Font.custom("Roboto",fixedSize: 16)).padding()
                .foregroundColor(Color.primary)
            Spacer()
        }
        .border(Color.gray, width: 2)
        
    }
}
