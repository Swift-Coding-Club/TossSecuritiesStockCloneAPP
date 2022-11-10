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
                .spoqaHan(family: .Medium, size: 20)
            
            Text(coin.currentPrice.asCurrencyWith2DecimalsValue() + "  KRW")
                .spoqaHan(family: .Medium, size: 13)
                .foregroundColor(Color.colorAssets.textColor)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? .zero) >= .zero ? Color.colorAssets.blue.opacity(0.8) : Color.colorAssets.red )
            .opacity(coin.priceChangePercentage24H == nil ? 0.0: 1.0)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background((coin.priceChangePercentage24H ?? .zero) == .zero ?
                        Color.clear :
                            (coin.priceChangePercentage24H ?? .zero) >= .zero ? Color.colorAssets.skyblue4.opacity(0.3) : Color.colorAssets.lightRed.opacity(0.3))
            .clipShape(Capsule())
        }
        .frame(width: 140, height: 160)
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
