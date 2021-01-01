//
//  ContentView.swift
//  DUNP-info
//
//  Created by Aleksandar on 04/11/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var settings: finishedTutorial = .shared
    var body: some View {
        if(settings.isOver) {
            TabNav() }
        else {
            TutorialView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class finishedTutorial: ObservableObject {
    private init() {}
    static let shared = finishedTutorial()
    @Published var isOver = getFinished()
}

