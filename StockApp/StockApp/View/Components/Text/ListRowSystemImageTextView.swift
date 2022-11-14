//
//  ListRowSystemImageTextView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/23.
//

import SwiftUI

struct ListRowSystemImageTextView: View {
    let title: String
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .resizable()
                .frame(width: width, height: height)
                .foregroundColor(Color.fontColor.accentColor)
            
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

struct ListRowSystemImageTextView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowSystemImageTextView(title: "로그아웃", imageName: "flame", width: 8, height: 10)
    }
}
