//
//  SeventhTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 16/11/2020.
//

import Foundation
import SwiftUI

struct SeventhTutorial: View {
    var body: some View {
        VStack{
        Text("Dobrodošli u DUNP-info! Uspešno ste podesili aplikaciju")
            .font(Font.custom("Ubuntu", fixedSize: 24))
            .bold()
            .padding(.bottom)
          //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
            .frame(width: UIScreen.main.bounds.width*0.90)
            Spacer()
            Text("Sve što ste podesili u prethodnim koracima možete i naknadno izmeniti u okviru aplikacije.")
               // .shadow(color: Color(hex: 0x02b9b5), radius: 0.2)
                .font(Font.custom("Roboto",fixedSize: 18))
                .frame(width: UIScreen.main.bounds.width*0.90).padding()
            
        }
    }
}
