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
            leftColumn()
            Spacer()
            if showHoldingsColumn {
                centerColumn()
            }
            rightColumn()
        }
        .spoqaHan(family: .Medium, size: 15)
        .background(
            Color.colorAssets.backGroundColor.opacity(0.001)
        )
    }
    //MARK: - 왼쪽

    @ViewBuilder
    private func leftColumn() ->  some View {
        HStack(spacing: .zero) {
            Text("\(coin.rank)")
                .spoqaHan(family: .Regular, size: 15)
                .foregroundColor(Color.colorAssets.textColor)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .spoqaHan(family: .Medium, size: 15)
                .padding(.leading, 6)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
    }
    
    //MARK: - 중앙
    @ViewBuilder
    private func centerColumn() ->  some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2DecimalsValue() + "  KRW")
                .spoqaHan(family: .Bold, size: 12)
            Text((coin.currentHoldings ?? .zero).asNumberString())
        }
        .foregroundColor(Color.fontColor.mainFontColor)
    }
    
    @ViewBuilder
    private func rightColumn() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2DecimalsValue() + "  KRW")
                .spoqaHan(family: .Bold, size: 12)
                .foregroundColor(Color.fontColor.mainFontColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .spoqaHan(family: .Regular, size: 10)
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= .zero ?
                    Color.colorAssets.skyblue4.opacity(0.8) : Color.colorAssets.red
                )
                .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                .background((coin.priceChangePercentage24H  ?? .zero) >= .zero ? Color.colorAssets.skyblue4.opacity(0.3) : Color.colorAssets.lightRed.opacity(0.3))
                .clipShape(Capsule())

        }
        .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
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
