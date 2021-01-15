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
    @State var image1 = UIImage()
    @State var image2 = UIImage()
    @State var showPicker = false
    @State var showAlert = false
    @State var sourceT: UIImagePickerController.SourceType = .photoLibrary
    @State var navActive = false
    @State var messageAlert = "Oba polja za slike su popunjena."
    
    func moveImages() -> Void {
        var temp: UIImage = UIImage()
        temp = image1
        image1 = image2
        image2 = temp
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Dodajte fotografije iz galerije ili kamere. Definišite redoled kojim će se slike prikazati ili obrišite sliku.").font(Font.custom("Roboto", size: 16)).foregroundColor(.primary).padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.primary, lineWidth: 2)
                ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
            HStack {
                Button(action: {
                    if(image1.size.width > 0 && image2.size.width > 0){
                        showAlert = true
                    } else {
                    showPicker.toggle()
                    }
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
                    if(image1.size.width > 0 && image2.size.width > 0){
                        messageAlert = "Oba polja za slike su popunjena."
                        showAlert = true
                    } else {
                    sourceT = .camera
                    showPicker.toggle()
                    }
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
                Image(uiImage: image1).resizable().scaledToFill()
                    .frame(width: 180, height: 180).border(Color.black, width: 1).clipped()
                HStack{
                Spacer()
                    Button(action: {
                        image1 = UIImage()
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
                Spacer()
                }
            }
            HStack {
                Image(uiImage: image2).resizable().scaledToFill()
                    .frame(width: 180, height: 180).border(Color.black, width: 1).clipped()
                HStack{
                Spacer()
                    Button(action: {
                        image2 = UIImage()
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
                Spacer()
                }
              }
            }.padding(.top)
            
            
            Spacer()
            HStack {
                
                Button(action: {
                    moveImages()
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
                    if image1.size.width == 0 && image2.size.width == 0 {
                        messageAlert = "Oba polja za slike su prazna."
                        showAlert = true
                    } else {
                    navActive.toggle()
                    }
                }) {
                    HStack{
                    Text("NASTAVI")
                        .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                        Image("arrow_right")
                            .foregroundColor(Color(hex: 0x5400cb))
                    }
                }.padding().frame(height:40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2))
                NavigationLink(destination: ExamUpload2(img1: image1, img2: image2), isActive: $navActive){}.hidden().frame(width:0).disabled(!navActive)
                        
            }
        }.frame(width: UIScreen.main.bounds.width*0.90)
        .navigationTitle("Dodaj slike").navigationBarTitleDisplayMode(.inline).padding([.top,.bottom])
        .sheet(isPresented: $showPicker, content: {ImagePickerView(isPresented: $showPicker, pickedImg: image1.size.width == 0 ? $image1 : $image2, sourceType: $sourceT)})
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Odabir slika"), message: Text(messageAlert))
        }
    }
}

