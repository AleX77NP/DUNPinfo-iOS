//
//  TabNav.swift
//  DUNP-info
//
//  Created by Aleksandar on 02/12/2020.
//

import Foundation
import SwiftUI

struct TabNav: View {
    var body: some View {
        TabView {
            News()
                .tabItem {
                    Image("menu_novosti")
                    Text("Novosti")
                }.tag(0)
            
            ExamsDep()
                .tabItem {
                    Image("menu_ispitni_rokovi")
                    Text("Ispitni rokovi")
                }.tag(1)
            
            Text("Dodaj ispitni rok")
                .tabItem {
                    Image("menu_dodaj_ispitni_rok")
                    Text("Dodaj ispitni rok")
                }.tag(2)
            
            Settings()
                .tabItem {
                    Image("menu_podesavanja")
                    Text("Podešavanja")
                }.tag(3)
        }
    }
}
