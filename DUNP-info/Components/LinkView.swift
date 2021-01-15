//
//  LinkView.swift
//  DUNP-info
//
//  Created by Aleksandar on 04/12/2020.
//

import Foundation
import SwiftUI
import SafariServices

struct LinkView: View {

    var link: String
    var tip: String
    
    var body: some View {
        if(self.tip != "instagram") {
            NewsWebView(link: self.link).navigationTitle("").navigationBarTitleDisplayMode(.inline)
        } else {
            SafariView(url: URL(string: self.link)!).navigationTitle("").navigationBarTitleDisplayMode(.inline)
        }
  }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
    

}
