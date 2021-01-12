//
//  SixthTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 16/11/2020.
//

import Foundation
import SwiftUI

struct SixthTutorial: View {
    @State var email: String = getMe() as! String
    @State var password: String = ""
    var body: some View{
        VStack{
          //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
        
        Form {
            Section(header: Text("LOGIN INFO")){
                HStack{
                    Spacer()
                Text("Podaci za prijavu")
                    .font(Font.custom("Ubuntu", fixedSize: 24))
                    .bold()
                    .padding()
                    Spacer()
                }
                Text("Email adresa:").font(Font.custom("Roboto", size: 16))
            TextField("Unesite email adresu", text: $email)
                Text("Lozinka:").font(Font.custom("Roboto", size: 16))
            SecureField("Unesite lozinku", text: $password)
                Button(action:
                        {
                            saveUserInfo(username: email, password: password)
                        }
                ) {
                    HStack{
                        Spacer()
                        Text("Sačuvaj").foregroundColor(Color(hex: 0x5400cb)).fontWeight(.bold).font(Font.custom("Ubuntu", fixedSize: 21))
                        Spacer()
                    }
                }.padding()
                
            }
        }.padding(.top)
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        }
        .onTapGesture {
            self.endTextEditing()
      }
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
