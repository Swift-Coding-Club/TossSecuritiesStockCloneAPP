//
//  ListRowTextView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/23.
//

import SwiftUI

struct ListRowTextView: View {
    let title: String
    let imageName: String
     
    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .frame(width: 15, height: 20)
                .foregroundColor(Color.fontColor.mainFontColor)
            
            Spacer()
                .frame(width: 10)
            
            Text(title)
                .spoqaHan(family: .Medium, size: 20)
                .foregroundColor(Color.fontColor.mainFontColor)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 15)
                .foregroundColor(Color.colorAssets.iconColor)
        }
    }
}

struct ListRowTextView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowTextView(title: "로그아웃", imageName: "flame")
    }
}
