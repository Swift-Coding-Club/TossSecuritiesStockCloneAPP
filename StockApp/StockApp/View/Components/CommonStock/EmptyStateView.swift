//
//  EmptyStateView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import SwiftUI

struct EmptyStateView: View {
    
    let text: String
    
    var body: some View {
        HStack{
            Spacer()
            Text(text)
                .ShareFont(size: 20, color: Color.colorAssets.textColor)
            Spacer()
        }
        .padding(64)
        .lineLimit(3)
        .multilineTextAlignment(.center)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(text: "추가된 데이터가 없어요!")
    }
}
