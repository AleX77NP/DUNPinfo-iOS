//
//  GalleryPicker.swift
//  DUNP-info
//
//  Created by Aleksandar on 13/01/2021.
//

import Foundation
import SwiftUI


struct ImagePickerView: UIViewControllerRepresentable {
  
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) ->  UIViewController {
        let controller = UIImagePickerController()
        return controller
    }
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
    
}
