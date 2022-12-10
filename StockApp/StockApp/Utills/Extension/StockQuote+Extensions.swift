//
//  StockQuote+Extensions.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import XCAStocksAPI

extension Quote {
    //MARK: - 거래 할때
    var isTrading: Bool {
        guard let marketState, marketState == "REGULAR" else {
            return false
        }
        return true
    }
    
    var regularPriceText: String? {
        Utils.stockFormat(value: regularMarketPrice)
    }
    
    var regularDiffText: String? {
        guard let text = Utils.stockFormat(value: regularMarketChange) else { return nil }
        return text.hasPrefix("-") ? text + "%" : "+\(text)" + "%"
    }
    
    var postPriceText: String? {
        Utils.stockFormat(value: postMarketPrice)
    }
    
    var postPriceDiffText: String? {
        guard let text = Utils.stockFormat(value: postMarketChange) else { return nil }
        return text.hasPrefix("-") ? text + "%" : "+\(text)" + "%"
    }
    
    var highText: String {
        Utils.stockFormat(value: regularMarketDayHigh) ?? "-"
    }
    
    var openText: String {
        Utils.stockFormat(value: regularMarketDayHigh) ?? "-"
    }
    
    var lowText: String {
        Utils.stockFormat(value: regularMarketDayLow) ?? "-"
    }
    
    var volText: String {
            regularMarketVolume?.formatUsingAbbrevation() ?? "-"
        }
        
        var peText: String {
            Utils.stockFormat(value: trailingPE) ?? "-"
        }
        
        var mktCapText: String {
            marketCap?.formatUsingAbbrevation() ?? "-"
        }
        
        var fiftyTwoWHText: String {
            Utils.stockFormat(value: fiftyTwoWeekHigh) ?? "-"
        }
        
        var fiftyTwoWLText: String {
            Utils.stockFormat(value: fiftyTwoWeekLow) ?? "-"
        }
        
        var avgVolText: String {
            averageDailyVolume3Month?.formatUsingAbbrevation() ?? "-"
        }
        
        var yieldText: String { "-" }
        var betaText: String { "-" }
        
        var epsText: String {
            Utils.stockFormat(value: epsTrailingTwelveMonths) ?? "-"
        }
    
    
       var columnItems: [QuoteDetailRowColumnItem] {
           [
               QuoteDetailRowColumnItem(rows: [
                   QuoteDetailRowColumnItem.RowItem(title: "개장가", value: openText),
                   QuoteDetailRowColumnItem.RowItem(title: "최고가", value: highText),
                   QuoteDetailRowColumnItem.RowItem(title: "최저가", value: lowText)
               ]), QuoteDetailRowColumnItem(rows: [
                   QuoteDetailRowColumnItem.RowItem(title: "거래량", value: volText),
                   QuoteDetailRowColumnItem.RowItem(title: "P/E", value: peText + " %"),
                   QuoteDetailRowColumnItem.RowItem(title: "시가총액", value: mktCapText)
               ]), QuoteDetailRowColumnItem(rows: [
                   QuoteDetailRowColumnItem.RowItem(title: "52주 최고", value: fiftyTwoWHText),
                   QuoteDetailRowColumnItem.RowItem(title: "52주 최저", value: fiftyTwoWLText),
                   QuoteDetailRowColumnItem.RowItem(title: "평균 거래량", value: avgVolText)
               ]), QuoteDetailRowColumnItem(rows: [
                   QuoteDetailRowColumnItem.RowItem(title: "수익률", value: yieldText),
                   QuoteDetailRowColumnItem.RowItem(title: "Beta", value: betaText),
                   QuoteDetailRowColumnItem.RowItem(title: "주당순이익", value: epsText)
               ])
           ]
       }
}
