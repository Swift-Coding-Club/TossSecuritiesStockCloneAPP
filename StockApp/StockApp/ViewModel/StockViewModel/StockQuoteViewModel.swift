//
//  StockQuoteViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import Combine
import XCAStocksAPI

@MainActor
class StockQuoteViewModel: ObservableObject {
    
    //MARK: - 주식의 데이터
    @Published var quotesDict: [String: Quote] = [:]
    let stocksAPI: StockApIService
    
    init(stocksAPI: StockApIService = XCAStocksAPI()) {
        self.stocksAPI = stocksAPI
    }
    
    func fetchQuote(tickers: [Ticker]) async {
        guard !tickers.isEmpty else { return }
        do {
            let symbols = tickers.map { $0.symbol }.joined(separator: ",")
            let quotes = try await stocksAPI.fetchQuotes(symbols: symbols)
            var dictionary = [String: Quote]()
            quotes.forEach { dictionary[$0.symbol] = $0 }
            self.quotesDict = dictionary
        }catch {
            print("stock fetch error\(error.localizedDescription)")
        }
    }
    
    func priceForTicker(_ ticker: Ticker) -> PriceChange? {
        guard let quote = quotesDict[ticker.symbol],
              let price  = quote.regularPriceText,
              let change = quote.regularDiffText
        else { return nil }
        return (price, change)
    }
    
}
