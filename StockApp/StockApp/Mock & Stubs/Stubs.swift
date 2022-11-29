//
//  Stubs.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import XCAStocksAPI

#if DEBUG
extension Ticker {
    static var stubs: [Ticker] {
        [
        Ticker(symbol: "AAPL", shortname: "Apple Inc"),
        Ticker(symbol: "TSLA", shortname: "Tesla"),
        Ticker(symbol: "NVDA", shortname: "Nvidia Corp"),
        Ticker(symbol: "AMD", shortname: "Advanced Micro Device")
        
        ]
    }
}
extension Quote {
    static var stubs: [Quote] {
        [
            Quote(symbol: "AAPL", regularMarketPrice: 150.43, regularMarketChange: -2.31),
            Quote(symbol: "TSLA", regularMarketPrice: 250.43, regularMarketChange: 2.39),
            Quote(symbol: "NVDA", regularMarketPrice: 100.43, regularMarketChange: -19.32),
            Quote(symbol: "AMD", regularMarketPrice: 70.43, regularMarketChange: 12.55),
        ]
    }
    
    static var subsDict : [String : Quote] {
        var dict = [String : Quote]()
        stubs.forEach { dict[$0.symbol] = $0 }
            return dict
        }
}



#endif
