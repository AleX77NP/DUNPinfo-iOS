//
//  Settings.swift
//  DUNP-info
//
//  Created by Aleksandar on 03/12/2020.
//

import Foundation
import SwiftUI


struct Settings : View {
    
    @State var isActive1 = false
    @State var isActive2 = false
    @State var isActive3 = false
    @State var showAlert = false
    
    @ObservedObject var settings: finishedTutorial = .shared
    @ObservedObject var deps: departmentsChanged = .sharedDeps
    @ObservedObject var courses: coursesChanged = .sharedCourses
    @ObservedObject var subs : subsChanged = .subsC
    
    init() {
       // print(getMyDepartments())
       /// print(getMyCourses())
       // print(vratiPretplate())
    }
    
    var body: some View {
        NavigationView{
        VStack {
            ScrollView{
            VStack {
                HStack{
                Text("Izmena departmana").font(Font.custom("Ubuntu", fixedSize: 21))
                    .bold()
                    .padding()
                  //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                    Spacer()
                }
                Text("Ovde možete da izmenite podešavanja za departmane za koje primate obaveštenja.").font(Font.custom("Roboto", size: 16)).padding().frame(width: UIScreen.main.bounds.width*0.90).foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.primary, lineWidth: 2)
                    ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                NavigationLink(destination: ThirdTutorial(), isActive: $isActive1) { HStack{
                Button(action: {
                    print("izmena")
                    self.isActive1.toggle()
                }) {
                    Image("edit")
                        .foregroundColor(Color(hex: 0x5400cb))
                    Text("IZMENI").fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                   
                }
                .padding(.vertical,12).padding(.horizontal,16)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
                )
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width*0.9)
                .padding()
            }
         }
            
            VStack {
                HStack{
                Text("Izmena smerova").font(Font.custom("Ubuntu", fixedSize: 21))
                    .bold()
                    .padding()
                  //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                    Spacer()
                }
                Text("Ovde možete da izmenite podešavanja za smerove za koje primate obaveštenja.").font(Font.custom("Roboto", size: 16)).padding().frame(width: UIScreen.main.bounds.width*0.90).foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.primary, lineWidth: 2)
                    ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                NavigationLink(destination: ForthTutorial(), isActive: $isActive2){HStack{
                Button(action: {
                    print("izmena")
                    self.isActive2.toggle()
                }) {
                    Image("edit")
                        .foregroundColor(Color(hex: 0x5400cb))
                    Text("IZMENI").fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                }
                .padding(.vertical,12).padding(.horizontal,16)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
                )
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width*0.9)
                .padding()
            }
            }
            
            
            VStack {
                HStack{
                Text("Izmena tipova novosti").font(Font.custom("Ubuntu", fixedSize: 21))
                    .bold()
                    .padding()
                   // .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                    Spacer()
                }
                Text("Ovde možete da izmenite podešavanja za tipove novosti za koje primate obaveštenja.").font(Font.custom("Roboto", size: 16)).padding().frame(width: UIScreen.main.bounds.width*0.90).foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.primary, lineWidth: 2)
                    ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                NavigationLink(destination: FifthTutorial(), isActive: $isActive3){
                    HStack{
                Button(action: {
                    print("izmena")
                    self.isActive3.toggle()
                }) {
                    Image("edit")
                        .foregroundColor(Color(hex: 0x5400cb))
                    Text("IZMENI").fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                    
                }
                .padding(.vertical,12).padding(.horizontal,16)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
                )
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width*0.9)
                .padding()
            }
          }
                
                
                VStack {
                    HStack{
                    Text("Reset podataka").font(Font.custom("Ubuntu", fixedSize: 21))
                        .bold()
                        .padding()
                      //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                        Spacer()
                    }
                    Text("Ovde možete da uradite potpuni reset podataka, nakon čega je neophodno podesiti aplikaciju iznova.").font(Font.custom("Roboto", size: 16)).padding().frame(width: UIScreen.main.bounds.width*0.90).foregroundColor(.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.primary, lineWidth: 2)
                        ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                    HStack{
                    Button(action: {
                        print("reset")
                        self.showAlert.toggle()
                    }) {
                        Text("RESET").fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                            .foregroundColor(Color(hex: 0x5400cb))
                        
                    }
                    .padding(.vertical,12).padding(.horizontal,16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                        
                    )
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width*0.9)
                    .padding()
              }
                
                
                
                }
        }.navigationTitle("Podešavanja").alert(isPresented: $showAlert) {
            Alert(title: Text("Reset podataka"), message: Text("Da li ste sigurni da želite da uradite potpuni reset aplikacije?"),
                  primaryButton: .destructive(Text("Da, jesam")){
                    resetApp()
                    self.deps.deps = []
                    self.courses.courses = []
                    self.subs.subs = []
                    self.settings.isOver = false
                  }, secondaryButton: .cancel())
        }
      }.navigationViewStyle(StackNavigationViewStyle())
    }
}
