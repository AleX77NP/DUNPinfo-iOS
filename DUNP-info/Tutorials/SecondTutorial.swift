//
//  SecondTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 11/11/2020.
//

import Foundation
import SwiftUI


struct SecondTutorial: View {
    var body: some View{
            VStack{
                Text("Pretraži ispitne rokove \nili slikaj i postavi rokove koji nedostaju")
                    .font(Font.custom("Ubuntu", fixedSize: 24))
                    .bold()
                    .padding(.bottom,6)
                   // .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                Spacer()
                Text("Pregledaj bazu ispitnih rokova za sve predmete, koja se gradi tako što studenti slikaju ispitne rokove i šalju.")
                    .font(Font.custom("Roboto", size: 18))
                    .padding(.top)
                  //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                    .frame(width: UIScreen.main.bounds.width*0.90)
               
             Text("")
        }.frame(width: UIScreen.main.bounds.width*0.95, alignment:.center)
     }
   }
