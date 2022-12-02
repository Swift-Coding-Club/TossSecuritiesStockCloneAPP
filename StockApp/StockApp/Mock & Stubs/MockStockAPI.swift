//
//  MockStockAPI.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/01.
//

import Foundation
import XCAStocksAPI

#if DEBUG
struct MockStockAPI : StockApIService {
 
    var stubbedSearchTickerCallback: ( () async  throws -> [Ticker])!
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker] {
         try await stubbedSearchTickerCallback()
    }
    
    var stubbedFetchQuoteCallBack: (()  async throws -> [Quote])!
    func fetchQuotes(symbols: String) async throws -> [Quote] {
        try await stubbedFetchQuoteCallBack()
    }
    
}

#endif
