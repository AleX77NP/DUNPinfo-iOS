//
//  ExamImage.swift
//  DUNP-info
//
//  Created by Aleksandar on 10/01/2021.
//

import Foundation
import SwiftUI

struct ExamImage: View {
    
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    
    var slika: String
    
    var body: some View {
        ZoomableScrollView{
            Image(uiImage: image).resizable()
                .aspectRatio(contentMode: .fit)
                            .onReceive(imageLoader.$data) { data in
                                guard let data = data else { return }
                                self.image = UIImage(data: data) ?? UIImage()
                            }
                    }.onAppear {
                        self.imageLoader.loadData(from: slika)
        }.navigationTitle("").navigationBarTitleDisplayMode(.inline)
    }
}



