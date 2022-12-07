//
//  TickerListRepository.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/03.
//

import Foundation
import XCAStocksAPI

protocol TickerListRepository {
    //MARK:  - 추가 해서 저장
    func save(_ current: [Ticker]) async throws
    //MARK:  - 추가 해서 로드
func load() async throws -> [Ticker]
    
}

@available(iOS 16.0, *)
class TickerPlistRepository: TickerListRepository {
    private var saved : [Ticker]?
    private let filename: String
    private var url: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[.zero]
            .appending(component: "\(filename).plist")
    }
    
    
    init(filename: String = "my_tickers") {
        self.filename = filename
    }
    
    func save(_ current: [Ticker]) async throws {
        if let saved, saved == current {
            return
        }
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        let data = try encoder.encode(current)
        try data.write(to: url, options: [.atomic])
        self.saved = current
    }
    
    func load() async throws -> [Ticker] {
        let data = try Data(contentsOf: url)
        let current = try PropertyListDecoder()
            .decode([Ticker].self, from: data)
        self.saved = current
        return current
        
    }
}
