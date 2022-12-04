//
//  ChartRangeViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import Foundation
import XCAStocksAPI

extension ChartRange : Identifiable {
    public var id: Self { self}
    
    var title: String {
        switch self {
        case .oneDay:
            return "1일"
        case .oneWeek:
            return "1주"
        case .oneMonth:
            return "1달"
        case .threeMonth:
            return "3달"
        case .sixMonth:
            return "6달"
        case .ytd:
            return "YTD"
        case .oneYear:
            return "1년"
        case .twoYear:
            return "2년"
        case .fiveYear:
            return "5년"
        case .tenYear:
            return "10년"
        case .max:
            return "모두"
        }
    }
}

