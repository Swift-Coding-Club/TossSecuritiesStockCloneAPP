//
//  AuthHeader.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/11.
//

import SwiftUI

struct AuthHeaderView: View {
    let authTopHeaderTitle: String
    let authCenterHeaderTitle: String
    let authBottomHeaderTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer()  }
            
            Text(authTopHeaderTitle)
                .font(.custom(FontAsset.mediumFont, size: 25))
                .fontWeight(.bold)
            
            Text(authCenterHeaderTitle)
                .font(.custom(FontAsset.regularFont, size: 23))
                .fontWeight(.semibold)
            
            Text(authBottomHeaderTitle)
                .font(.custom(FontAsset.regularFont, size: 23))
                .fontWeight(.semibold)
        }
        .frame(height: (UIScreen.main.bounds.height / 4) + 30)
        .padding(.leading)
        .background(Color.colorAssets.mainColor)
        .foregroundColor(Color.colorAssets.white)
        //MARK:  - 바텀 쪽 코너를 둥굴게 구현
        .clipShape(RoundShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(authTopHeaderTitle: "안녕하세요",
                       authCenterHeaderTitle: "어서오세요 코인 모여 서비스에 오신걸 ",
                       authBottomHeaderTitle: "환영합니다")
    }
}
