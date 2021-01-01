//
//  NewsListItem.swift
//  DUNP-info
//
//  Created by Aleksandar on 17/11/2020.
//

import Foundation
import SwiftUI

struct NewsListItem: View {
    var item: NewsItem
    var color: Color
    
    var body: some View {
        NavigationLink(destination: LinkView(link: item.fields.link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, tip: item.fields.tip)){
            HStack(alignment: .top){
            Image(item.fields.tip == "vesti" ? "novosti" : item.fields.tip.replacingOccurrences(of: " ", with: "_")).resizable().frame(width: 25, height: 25)
                .padding().foregroundColor(color)
                VStack(alignment: .leading){
                    Text(item.fields.naslov) .lineLimit(2).font(Font.custom("Ubuntu", size: 14))
                    Text(item.fields.datum.prefix(16).replacingOccurrences(of: "T", with:" ")).padding(.top,10).foregroundColor(Color.gray).font(Font.custom("Roboto", size: 14))
                }
        }
      }
    }
}

