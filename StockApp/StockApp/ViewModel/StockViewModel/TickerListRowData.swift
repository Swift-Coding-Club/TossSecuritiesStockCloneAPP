//
//  TickerListRowData.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import XCAStocksAPI

typealias PriceChange = (price: String, change: String)

struct TickerListRowData {
    
    enum RowType {
        case main
        case search(isSaved: Bool, onButtonTapped: () -> ())
    }
    
    let symbol: String
    let name: String
    let price: PriceChange?
    let type: RowType
}

