//
//  StockConvertViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import Foundation

enum StockConvertViewModel : Int , CaseIterable, CustomStringConvertible  {
    case myInterestMarket
    case nsdMarketCap
    case newYorkStock
    case littleChange
    case largeChange
    
    var description: String {
        switch self {
        case .myInterestMarket:
            return "관심 있는 주식"
        case .nsdMarketCap:
            return "나스닥 시가총액 "
        case .newYorkStock:
            return "뉴욕 거래소 시가총액"
        case .littleChange:
            return "변화량이 적은 순"
        case .largeChange:
            return "변화량이 많은 순 "
        }
    }
}
