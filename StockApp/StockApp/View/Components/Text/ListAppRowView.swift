//
//  ListAppRowView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/10.
//

import SwiftUI

struct ListAppRowView: View {
    
    let title: String
    let appVersionTitle: String
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 10)
            
            HStack(spacing: .zero){
                
                Text(title)
                    .spoqaHan(family: .Medium, size: 20)
                    .foregroundColor(Color.fontColor.mainFontColor)
                
                Spacer()
                
                Text(appVersionTitle)
                    .spoqaHan(family: .Regular, size: 20)
                    .foregroundColor(Color.colorAssets.mainColor2)
            }
        }
    }
}

struct ListAppRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListAppRowView(title: "버전 정보",  appVersionTitle: "1.0.1")
    }
}
