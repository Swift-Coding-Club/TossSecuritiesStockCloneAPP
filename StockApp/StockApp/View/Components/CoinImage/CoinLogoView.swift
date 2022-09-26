//
//  CoinLogoView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/26.
//

import SwiftUI

struct CoinLogoView: View {
    //MARK:  - 코인 모델 생성
    let coin: CoinModel
    
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50 ,height: 50)
            Text(coin.symbol.uppercased())
                .font(.custom(FontAsset.mediumFont, size: 18))
                .foregroundColor(Color.fontColor.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.custom(FontAsset.regularFont, size: 15))
                .foregroundColor(Color.colorAssets.textColor)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
        }
    }
}
