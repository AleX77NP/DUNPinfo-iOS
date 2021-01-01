//
//  FirstTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 10/11/2020.
//

import Foundation
import SwiftUI


struct FirstTutorial: View {
    var body: some View{
            VStack{
                Text("Prati sve važne informacije sa Državnog univerziteta u Novom Pazaru")
                    .font(Font.custom("Ubuntu", fixedSize: 24))
                    .bold()
                    .padding(.bottom,6)
                   // .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                Spacer()
                Text("Aplikacija automatski izdvaja informacije sa sajta, moodle platforme i instagrama.")
                    .font(Font.custom("Roboto", size: 18))
                    .padding(.bottom)
                  //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                    .frame(width: UIScreen.main.bounds.width*0.90)
               
             Text("")
        }.frame(width: UIScreen.main.bounds.width*0.95, alignment:.center)
     }
   }



