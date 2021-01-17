//
//  ExamUpload2.swift
//  DUNP-info
//
//  Created by Aleksandar on 15/01/2021.
//

import Foundation
import SwiftUI

struct ExamUpload2: View {
    
    @Binding var goRoot: Bool
    
    var img1 : UIImage
    var img2 : UIImage
    
    var predmet2: Int
    var godina2: Int
    var rok2: String
    var nazivPr2 : String
    @State var message = ""
    @State var isUploading = false
    @State var showAlert = false
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        
        isUploading = true
        let url = URL(string: "http://68.66.242.98/api/faks/ispit/") //promeni

        let boundary = UUID().uuidString
        
        let parameters: [String: Any] = [
            "predmet": predmet2,
            "ispitni_rok": rok2,
            "godina": godina2
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
        data.append(image.jpegData(compressionQuality: 0.55)!)
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
                    isUploading = false
                    message = "Uspešno ste poslali ispitni rok! \n\nIspitni rok sada čeka na odobrenje admina."
                    showAlert = true
                }
            } else {
                isUploading = false
                message = "Došlo je do neke greške prilikom upload-a slike!"
                showAlert = true
            }
        }).resume()
    }

    
    var body: some View {
        VStack{
            if isUploading {
            ProgressView().padding()
            }
            ScrollView(showsIndicators: false){
            VStack{
                Text(nazivPr2).bold().padding(.bottom,2)
                Text(rok2 + " " + String(godina2)).bold().italic().padding(.bottom,2)
                
            }.frame(width: 300).lineLimit(1)
            
                Text("Proverite još jednom da li je sve u redu, slike su spojene u jednu i izvršena je kompresija").font(Font.custom("Roboto", size: 15)).foregroundColor(.primary).padding().frame(width: 298)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.primary, lineWidth: 2)
                    ).background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                
            if(img1.size.width > 0) {
            Image(uiImage: img1).resizable().frame(width:300, height: 450).scaledToFill().border(Color.primary, width: 1).clipped()
            }
            if(img2.size.width > 0) {
            Image(uiImage: img2).resizable().frame(width:300, height: 450).scaledToFill().border(Color.primary, width: 1).clipped()
              }
            }
            HStack {
                Spacer()
                HStack{
                    Spacer()
            Button(action: {
                let fileN = (nazivPr2 + rok2 + String(godina2) + currDate()).replacingOccurrences(of: " ", with: "_") + ".jpg"
                let merged = mergeImages(image1: img1, image2: img2)
                let newImg = resizeImage(image: merged, newWidth: 1080.0)
                uploadImage(paramName: "slika", fileName: fileN, image: newImg)
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Upload"), message: Text(message),primaryButton: .destructive(Text("U redu")) {
                goRoot = false
        }, secondaryButton: .cancel())
        }
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

func currDate() -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let formattedDate = format.string(from: date)
    return formattedDate
}

