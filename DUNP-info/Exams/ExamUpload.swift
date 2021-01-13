//
//  ExamUpload.swift
//  DUNP-info
//
//  Created by Aleksandar on 12/01/2021.
//

import Foundation
import SwiftUI

struct ExamUpload: View {
    
    var predmet: Int
    var godina: Int
    var rok: String
    @State var img1 = 0
    @State var img2 = 0
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Dodajte fotografije iz galerije ili kamere. Definišite redoled kojim će se slike prikazati ili obrišite sliku.").font(Font.custom("Roboto", size: 16)).foregroundColor(.primary).padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.primary, lineWidth: 2)
                ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
            HStack {
                Button(action: {
                    print("galerija")
                    img1 = 1
                }) {
                    Text("GALERIJA").fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                    
                }
                .padding(.vertical,12).padding(.horizontal,16)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
                )
                
                Button(action: {
                    print("kamera")
                    img2 = 1
                }) {
                    Image("add_a_photo")
                        .foregroundColor(Color(hex: 0x5400cb))
                    
                }
                .padding(.vertical,12).padding(.horizontal,16)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
                )
                Spacer()
                
            }
            VStack{
            HStack {
                Image(uiImage: UIImage()).frame(width: 180, height: 180).border(Color.black, width: 1)
                HStack{
                Spacer()
                    VStack{
                    Button(action: {
                        
                    }) {
                    HStack{
                    Image("close").foregroundColor(Color(hex: 0x5400cb))
                        Text("Obriši").font(Font.custom("Roboto", size: 16)).foregroundColor(Color(hex: 0x5400cb))
                        }
                    } .padding(.vertical,12).padding(.horizontal,16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                        
                    )
                        Button(action: {
                            
                        }) {
                        HStack{
                        Image("edit").foregroundColor(Color(hex: 0x5400cb))
                            Text("Izmeni").font(Font.custom("Roboto", size: 16)).foregroundColor(Color(hex: 0x5400cb))
                            }
                        } .padding(.vertical,12).padding(.horizontal,16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                            
                        ).padding(.top)
                    }
                Spacer()
                }
            }.opacity(img1 > 0 ? 1 : 0)
            HStack {
                Image(uiImage: UIImage()).frame(width: 180, height: 180).border(Color.black, width: 1)
                HStack{
                Spacer()
                    VStack{
                    Button(action: {
                    }) {
                HStack{
                Image("close").foregroundColor(Color(hex: 0x5400cb))
                Text("Obriši").font(Font.custom("Roboto", size: 16)).foregroundColor(Color(hex: 0x5400cb))
                    }
                    } .padding(.vertical,12).padding(.horizontal,16)
                    .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
                    )
                        
                        Button(action: {
                        }) {
                    HStack{
                    Image("edit").foregroundColor(Color(hex: 0x5400cb))
                    Text("Izmeni").font(Font.custom("Roboto", size: 16)).foregroundColor(Color(hex: 0x5400cb))
                        }
                        } .padding(.vertical,12).padding(.horizontal,16)
                        .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                        
                    ).padding(.top)
                    }
                Spacer()
                }
            }.opacity(img2 > 0 ? 1 : 0)
            }.padding(.top)
            
            
            Spacer()
            HStack {
                
                Button(action: {
                }) {
                    Text("ZAMENI")
                        .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                }.padding().frame(height:40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2))
                
                Spacer()
                Button(action: {
                }) {
                    HStack{
                    Text("UPLOAD")
                        .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                        Image("arrow_right")
                            .foregroundColor(Color(hex: 0x5400cb))
                    }
                }.padding().frame(height:40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2))
                        
            }
        }.frame(width: UIScreen.main.bounds.width*0.90)
        .navigationTitle("Dodaj slike").navigationBarTitleDisplayMode(.inline).padding([.top,.bottom])
    }
}

