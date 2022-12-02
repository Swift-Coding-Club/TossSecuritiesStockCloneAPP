//
//  StockApiService.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/01.
//

import Foundation
import XCAStocksAPI

protocol StockApIService {
    //MARK: - 검색
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker]
    //MARK: - 주식 fetch
    func fetchQuotes(symbols: String) async throws -> [Quote]
}


extension XCAStocksAPI: StockApIService { }

