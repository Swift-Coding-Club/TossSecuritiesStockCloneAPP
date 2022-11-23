//
//  StocklistParm.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/22.
//

import Foundation

enum StocklistParm : CustomStringConvertible {
    case most_actives
    case small_cap_gainers
    case aggressive_small_caps
    case undervalued_large_caps
    
    var description: String {
        switch self {
        case .most_actives:
            return "most_actives"
        case .small_cap_gainers:
            return "small_cap_gainers"
        case .aggressive_small_caps:
            return "aggressive_small_caps"
        case .undervalued_large_caps:
            return "undervalued_large_caps"
        }
    }
}
