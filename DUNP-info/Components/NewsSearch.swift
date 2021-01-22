//
//  NewsSearch.swift
//  DUNP-info
//
//  Created by Aleksandar on 07/12/2020.
//

import Foundation
import SwiftUI

struct NewsSearchBar: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Pretraži"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<NewsSearchBar>) {
        uiView.text = text
    }
    
    func makeCoordinator() -> NewsSearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if searchText.count < 1 {
                searchBar.resignFirstResponder()
            }
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
}
