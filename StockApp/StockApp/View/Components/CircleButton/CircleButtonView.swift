//
//  CircleButtonView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct CircleButtonView: View {
    //MARK: - 아이콘이름
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.custom(FontAsset.regularFont, size: 20))
            .foregroundColor(Color.fontColor.accentColor)
            .frame(width: 50, height: 50)
            .background(
            Circle()
                .foregroundColor(Color.colorAssets.backGroundColor)
            )
            .shadow(
                color: Color.fontColor.accentColor.opacity(0.25),
                radius: 10, x: .zero, y: .zero)
            .padding()
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(iconName: "heart.fill")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
