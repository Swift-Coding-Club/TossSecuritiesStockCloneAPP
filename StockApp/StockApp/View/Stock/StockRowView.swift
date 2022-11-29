//
//  StockRowView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import SwiftUI

struct StockRowView: View {
    let stock : QuoteResponseRow
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading) {
                Text(stock.symbol?.uppercased() ?? "")
                    .spoqaHan(family: .Bold, size: 12)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(Color.fontColor.mainFontColor)
                
                Spacer()
                    .frame(height: 3)
                
                Text(stock.shortName?.uppercased() ?? "")
                    .spoqaHan(family: .Bold, size: 12)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(Color.colorAssets.textColor)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if let stockPrice = stock.regularMarketPrice {
                    Text((stockPrice * 1326.95).asCurrencyWith2DecimalsValue() + " KRW")
                        .spoqaHan(family: .Bold, size: 12)
                }
                Spacer()
                    .frame(height: 3)
                
                Text(stock.regularMarketChangePercent?.asPercentString() ?? "")
                    .spoqaHan(family: .Regular, size: 10)
                    .foregroundColor(
                        (stock.regularMarketChangePercent ?? 0) >= .zero ?
                        Color.colorAssets.skyblue4.opacity(0.8) : Color.colorAssets.red
                    )
                    .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                    .background((stock.regularMarketChangePercent  ?? .zero) >= .zero ? Color.colorAssets.skyblue4.opacity(0.3) : Color.colorAssets.lightRed.opacity(0.3))
                    .clipShape(Capsule())       
            }
        }
    }
}

struct StockRowView_Previews: PreviewProvider {
    static var previews: some View {
        StockRowView(stock: dev.stock)
    }
}
