//
//  ExamUpload.swift
//  DUNP-info
//
//  Created by Aleksandar on 12/01/2021.
//

import Foundation
import SwiftUI


struct ExamUpload: View {
    
    @Binding var rootIsActive : Bool
    
    var predmet: Int
    var godina: Int
    var rok: String
    var nazivPr : String
    @State var image1 = UIImage()
    @State var counter = 1
    @State var image2 = UIImage()
    @State var chosenImg = UIImage()
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
            Text("Dodajte fotografije iz galerije ili kamere. Definišite redosled kojim će se slike prikazati ili obrišite sliku.").font(Font.custom("Roboto", size: 16)).foregroundColor(.primary).padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.primary, lineWidth: 2)
                ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
            HStack {
                Button(action: {
                    if(image1.size.width > 0 && image2.size.width > 0){
                        showAlert = true
                    } else {
                        self.sourceT = .photoLibrary
                        self.showPicker.toggle()
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
                        self.sourceT = .camera
                        self.showPicker.toggle()
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
                Image(uiImage: image1).resizable().scaledToFit()
                    .frame(width: 180, height: 180).border(Color.primary, width: 1).clipped()
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
            }.opacity(image1.size.width > 0 ? 1: 0)
            HStack {
                Image(uiImage: image2).resizable().scaledToFit()
                    .frame(width: 180, height: 180).border(Color.primary, width: 1).clipped()
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
              }.opacity(image2.size.width > 0 ? 1: 0)
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
                NavigationLink(destination: ExamUpload2(goRoot: $rootIsActive ,img1: image1, img2: image2, predmet2: predmet, godina2: godina, rok2: rok, nazivPr2: nazivPr), isActive: $navActive){}.hidden().frame(width:0).disabled(!navActive)
                        
            }
        }.frame(width: UIScreen.main.bounds.width*0.90)
        .navigationTitle("Dodaj slike").navigationBarTitleDisplayMode(.inline).padding([.top,.bottom])
        .sheet(isPresented: $showPicker, content: {ImagePickerView(isPresented: $showPicker, pickedImg: self.image1.size.width == 0 ? $image1 : $image2, sourceType: $sourceT)})
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Odabir slika"), message: Text(messageAlert))
        }
    }
}

