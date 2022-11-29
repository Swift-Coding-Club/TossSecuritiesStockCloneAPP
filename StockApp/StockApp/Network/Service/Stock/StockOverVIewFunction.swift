//
//  StockOverVIewFunction.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/26.
//

import Foundation

enum StockOverVIewFunction: Int ,CaseIterable, CustomStringConvertible {
    case overview
    case lobalQuote
    
    var description: String {
        switch self {
        case .overview:
            return "OVERVIEW"
        case .lobalQuote:
            return "GLOBAL_QUOTE"
        }
    }
}
