//
//  HomeConverStockViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/09.
//

import Foundation

enum HomeConverStockViewModel: Int, CaseIterable, CustomStringConvertible {
    case nsd
    case newyork
    
    var description: String {
        switch self {
        case .nsd:
            return "나스닥 인기 주식"
        case .newyork:
            return "뉴욕 거래소 인기 주식"
        }
    }
}
