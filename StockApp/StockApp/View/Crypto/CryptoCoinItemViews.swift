//
//  CryptoCoinItemViews.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/02.
//

import SwiftUI

struct CryptoCoinItemViews: View {
    let coin : CoinModel
    var body: some View {
        VStack(alignment: .leading) {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.custom(FontAsset.mediumFont, size: 20))
            
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .font(.custom(FontAsset.mediumFont, size: 13))
                .foregroundColor(Color.colorAssets.textColor)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= .zero ?
                    Color.colorAssets.green : Color.colorAssets.red
                )
        }
        .frame(width: 140, height: 140)
        .background(
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.colorAssets.backGroundColor)
            .shadow(color: Color.fontColor.accentColor.opacity(0.15),
                    radius: 10, x: .zero, y: .zero)
        )
    }
}

struct CryptoCoinItemViews_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCoinItemViews(coin: dev.coin)
    }
}
