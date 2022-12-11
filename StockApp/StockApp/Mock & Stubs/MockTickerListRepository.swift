//
//  MockTickerListRepository.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/03.
//

import Foundation
import XCAStocksAPI


struct MockTickerListRepository: TickerListRepository {
    
    var stubbedLoad: (() async throws -> [Ticker])!
    
    func load() async throws -> [Ticker] {
        try await stubbedLoad()
    }
    
    func save(_ current: [Ticker]) async throws {
        
    }
}

