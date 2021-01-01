//
//  NewsLink.swift
//  DUNP-info
//
//  Created by Aleksandar on 28/11/2020.
//

import Foundation
import SwiftUI
import WebKit

struct NewsWebView: UIViewRepresentable {
    var link: String
    
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: self.link.replacingOccurrences(of: "http", with: "https")) else {
                return WKWebView()
            }
            print(url)
            let request = URLRequest(url: url)
            let wkWebview  = WKWebView()
            wkWebview.load(request)
            return wkWebview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
}
