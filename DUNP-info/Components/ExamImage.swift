//
//  ExamImage.swift
//  DUNP-info
//
//  Created by Aleksandar on 10/01/2021.
//

import Foundation
import SwiftUI

struct ExamImage: View {
    
    var slika: String
    
    var body: some View {
        ScrollView{
        Image(systemName: "placeholder image")
        .data(url: URL(string: slika)!)
            .aspectRatio(contentMode: .fill)
        }
    }
}



extension Image {
func data(url:URL) -> Self {
if let data = try? Data(contentsOf: url) {
return Image(uiImage: UIImage(data: data)!)
.resizable()
}
return self
.resizable()
}
}
