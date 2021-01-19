//
//  GalleryPicker.swift
//  DUNP-info
//
//  Created by Aleksandar on 13/01/2021.
//

import Foundation
import SwiftUI


struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var pickedImg: UIImage
    @Binding var sourceType: UIImagePickerController.SourceType
  
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) ->  UIViewController {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        let parent : ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.parent.pickedImg = selectedImage
            }
            self.parent.isPresented = false
        }
    }
    
}
