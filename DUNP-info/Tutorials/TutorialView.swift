//
//  TutorialView.swift
//  DUNP-info
//
//  Created by Aleksandar on 11/11/2020.
//

import Foundation
import SwiftUI

struct TutorialView: View {
    @State var CurrentPage = 0
    @State private var showAlert = false
    @ObservedObject var settings: finishedTutorial = .shared
    var body: some View {
        ZStack(alignment: .bottom){
            if CurrentPage != 2 && CurrentPage != 3 && CurrentPage != 4 && CurrentPage != 5 {
                Image(CurrentPage == 0 ? "illustration_1" : CurrentPage == 1 ? "illustration_2" : "illustration_3")
            .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.bottom)
            }
        VStack{
            TutorialHeader(Current: CurrentPage).padding(30)
            if self.CurrentPage == 0 {
                FirstTutorial()
            }
            else if self.CurrentPage == 1 {
                SecondTutorial()
            }
            else if self.CurrentPage == 2 {
                ThirdTutorial()
            }
            else if self.CurrentPage == 3 {
                ForthTutorial()
            }
            else if self.CurrentPage == 4 {
                FifthTutorial()
            }
            else if self.CurrentPage == 5 {
                SixthTutorial()
            }
            else if self.CurrentPage == 6 {
                SeventhTutorial()
            }
            HStack{
                VStack{
            Button(action: {
                print("Hello button tapped!")
                if(self.CurrentPage > 0) {
                self.CurrentPage -= 1;
                }
            })
            {
                    Image("arrow_left")
                        .foregroundColor(Color(hex: 0x5400cb))
                Text("NAZAD")
                    .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                    .foregroundColor(Color(hex: 0x5400cb))
              
            }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                
             )
                    Text("")
                }
                Spacer()
                VStack{
                Button(action: {
                    if self.CurrentPage == 2 {
                        if(canGoNext3()) {
                            self.CurrentPage += 1
                        } else {
                            self.showAlert = true
                        }
                    }
                    else if self.CurrentPage == 3 {
                        if(canGoNext4()) {
                            self.CurrentPage += 1
                        }
                        else {
                            self.showAlert = true
                        }
                    }
                    else if self.CurrentPage == 4 {
                        if(canGoNext5()) {
                            self.CurrentPage += 1
                        }
                        else {
                            self.showAlert = true
                        }
                    }
                    else if self.CurrentPage == 5 {
                        if(canGoNext6()) {
                            self.CurrentPage += 1
                        }
                        else {
                            self.showAlert = true
                        }
                    }
                    else if self.CurrentPage == 6 {
                        UserDefaults.standard.setValue("finished", forKey: "finishedT")
                        UserDefaults.standard.setValue(0, forKey: "latest_id")
                        onFinishTutorial()
                        self.settings.isOver = true
                    }
                    
                    else {
                        self.CurrentPage += 1;
                    }
                })
                {
                    Text("NAPRED")
                        .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                        .foregroundColor(Color(hex: 0x5400cb))
                        Image("arrow_right")
                            .foregroundColor(Color(hex: 0x5400cb))
                  
                }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(hex: 0x5400cb), lineWidth: 2)
                    
             )
                    Text("")
                }
           }.frame(width: UIScreen.main.bounds.width*0.80, alignment:.center)
        }.padding(.bottom)
        }.frame(height: UIScreen.main.bounds.height*1).alert(isPresented: $showAlert) {
            Alert(title: Text("Podešavanja"), message: Text("Morate odabrati barem jednu od datih opcija, ili uneti neophodne podatke kako biste nastavili dalje."))
        }
    }
}


func canGoNext3() -> Bool {
    let selectedDeps = getMyDepartments()
    if selectedDeps.isEmpty {
        return false
    }
    else {
        return true
    }
}

func canGoNext4() -> Bool {
    let selectedC = getMyCourses()
    if selectedC.isEmpty {
        return false
    }
    else {
        return true
    }
}

func canGoNext5() -> Bool {
    let pretplate = vratiPretplate()
    if pretplate.count == 0 {
        return false
    }
    return true
}

func canGoNext6() -> Bool {
    let me = getMe()
    if me as! String == "" {
        return false
    }
    return true
}
