//
//  ExamUpload.swift
//  DUNP-info
//
//  Created by Aleksandar on 12/01/2021.
//

import Foundation
import SwiftUI

struct ExamUpload: View {
    
    var predmet: Int
    var godina: Int
    var rok: String
    
    var body: some View {
        VStack{
        Text(String(predmet))
        Text(String(godina))
        Text(rok)
        }
    }
}
