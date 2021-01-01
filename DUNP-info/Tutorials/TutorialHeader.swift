//
//  TutorialHeader.swift
//  DUNP-info
//
//  Created by Aleksandar on 10/11/2020.
//

import Foundation
import SwiftUI
import UIKit

struct TutorialHeader: UIViewRepresentable {
    
    var Current: Int;
    
    func makeUIView(context: UIViewRepresentableContext<TutorialHeader>) -> UIPageControl {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor(hex: "5400cb")
        page.numberOfPages = 7
        page.pageIndicatorTintColor = .gray
        return page
    }
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = Current
    }
   
}
