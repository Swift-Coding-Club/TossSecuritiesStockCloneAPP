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
    
    var description: String {
        switch self {
        case .myInterestMarket:
            return "관심 있는 주식"
        case .nsdMarketCap:
            return "나스닥 시가총액 "
        case .newYorkStock:
            return "뉴욕 거래소 시가총액"
        }
    }
}
