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
    
    var predmet2: Int
    var godina2: Int
    var rok2: String
    var nazivPr2 : String
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = URL(string: "http://127.0.0.1:8000/api/faks/ispit/")

        let boundary = UUID().uuidString
        
        let parameters: [String: Any] = [
            "predmet": 1,
            "ispitni_rok": "Oktobar3",
            "godina": 2045
        ]

        let session = URLSession.shared

     
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

    
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)
        data.append(image.jpegData(compressionQuality: 0.5)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
            for (key, value) in parameters {
                data.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                data.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        
        

        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }

    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
            if(img1.size.width > 0) {
            Image(uiImage: img1).resizable().frame(width:300, height: 450).scaledToFill().clipped()
            }
            if(img2.size.width > 0) {
            Image(uiImage: img2).resizable().frame(width:300, height: 450).scaledToFill().clipped()
              }
            }
            HStack {
                Spacer()
                HStack{
                    Spacer()
            Button(action: {
                print(img1)
                let merged = mergeImages(image1: img1, image2: img2)
                print(merged.size.height)
                print(merged.size.width)
                let newImg = resizeImage(image: merged, newWidth: 1080.0)
                print(newImg.size.height*newImg.scale)
                print(newImg.size.width*newImg.scale)
                uploadImage(paramName: "slika", fileName: "rok1.jpg", image: newImg)
            }) {
                HStack{
                Text("UPLOAD")
                    .fontWeight(.bold).font(Font.custom("Raleway", fixedSize: 18))
                    .foregroundColor(Color(hex: 0x5400cb))
                    Image("arrow_right")
                        .foregroundColor(Color(hex: 0x5400cb))
                }
            }.padding().frame(height:40)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: 0x5400cb), lineWidth: 2))
                    
            }.padding()
                
            }
        }.padding(.top)
        .navigationTitle("Slike").navigationBarTitleDisplayMode(.inline)
    }
}

//promena velicine slike na 1080px sirine
func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

//spajanje 2 slike
func mergeImages(image1: UIImage, image2: UIImage) -> UIImage {
        let size = CGSize(width: image1.size.width, height: image1.size.height + image2.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        image1.draw(in: CGRect(x:0, y:0, width:size.width, height: image1.size.height))
        image2.draw(in: CGRect(x:0, y:image1.size.height, width: size.width,  height: image2.size.height))

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    
        return newImage
}

