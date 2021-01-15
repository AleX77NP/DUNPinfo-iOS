//
//  ExamUpload2.swift
//  DUNP-info
//
//  Created by Aleksandar on 15/01/2021.
//

import Foundation
import SwiftUI

struct ExamUpload2: View {
    
    var img1 : UIImage
    var img2 : UIImage
    
    var body: some View {
        VStack{
            ScrollView{
        Text("Ovde ide upload")
            if(img1.size.width > 0) {
            Image(uiImage: img1).resizable().frame(width:300, height: 500).scaledToFill().clipped()
            }
            if(img2.size.width > 0) {
            Image(uiImage: img2).resizable().frame(width:300, height: 500).scaledToFill().clipped()
              }
            }
        }
    }
}
