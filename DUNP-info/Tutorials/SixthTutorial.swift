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
    @State var password: String = getPwd() as! String
    
    var disableForm: Bool {
        email.count < 5 || password.count < 6 || !email.contains("@")
    }
    var body: some View{
        VStack{
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
                Text("Email adresa:").bold()
                TextField("Unesite email adresu", text: $email)
                Text("Lozinka:").bold()
                SecureField("Unesite lozinku", text: $password)
                Button(action:
                        {
                            saveUserInfo(username: email, password: password)
                            
                        }
                ) {
                    HStack{
                        Spacer()
                        Text("Sačuvaj").foregroundColor(Color.primary).fontWeight(.bold).font(Font.custom("Ubuntu", fixedSize: 21))
                        Spacer()
                    }
                }.padding().buttonStyle(PlainButtonStyle()).disabled(disableForm)
                
                VStack{
                    Text("Neophodno je da unesete validnu adresu e-pošte, koja se koristi kao identifikator za notifikacije koje ćete dobijati. Lozinka je proizvoljna i biće bezbedno smeštena u bazi.").font(Font.custom("Roboto", size: 15)).foregroundColor(.primary).padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.primary, lineWidth: 2)
                        
                    ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
               
                }.padding(.vertical)
            }
            
        }
        .padding(.top)
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
