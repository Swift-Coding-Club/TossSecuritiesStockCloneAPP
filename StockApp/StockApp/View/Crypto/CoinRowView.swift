//
//  CoinRowView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/21.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: .zero) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.custom(FontAsset.mediumFont, size: 15))
        .background(
            Color.colorAssets.backGroundColor.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin:  dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin:  dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: .zero) {
            Text("\(coin.rank)")
                .font(.custom(FontAsset.mediumFont, size: 15))
                .foregroundColor(Color.colorAssets.textColor)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.custom(FontAsset.mediumFont, size: 15))
                .padding(.leading, 6)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? .zero).asNumberString())
        }
        .foregroundColor(Color.fontColor.mainFontColor)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.fontColor.mainFontColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= .zero ?
                    Color.colorAssets.green : Color.colorAssets.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
    }
}
