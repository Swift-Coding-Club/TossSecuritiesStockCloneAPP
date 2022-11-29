//
//  StockQuoteViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import Combine
import XCAStocksAPI

class StockQuoteViewModel: ObservableObject {
    
    //MARK: - 주식의 데이터
    @Published var quotesDict: [String: Quote] = [:]
    
    func priceForTicker(_ ticker: Ticker) -> PriceChange? {
        guard let quote = quotesDict[ticker.symbol],
              let price = quote.regularPriceText,
              let change = quote.regularDiffText
        else { return  nil }
        return (price, change)
    }
    
}
