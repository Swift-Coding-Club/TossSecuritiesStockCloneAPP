//
//  StockQuote+Extensions.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import XCAStocksAPI

extension Quote {
    var regularPriceText: String? {
        Utils.stockFormat(value: regularMarketPrice)
        }
    
    var regularDiffText: String? {
        guard let text = Utils.stockFormat(value: regularMarketChange) else { return nil }
        return text.hasPrefix("-") ? text + "%" : "+\(text)" + "%"
    }
}
