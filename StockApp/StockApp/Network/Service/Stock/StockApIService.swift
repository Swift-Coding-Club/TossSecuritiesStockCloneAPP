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
    //MARK: - 주식 차트 데이터 가져오기
    func fetchChartData(tickerSymbol: String, range: ChartRange) async throws -> ChartData?

}


extension XCAStocksAPI: StockApIService { }

