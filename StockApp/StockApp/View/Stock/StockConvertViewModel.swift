//
//  StockConvertViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import Foundation

enum StockConvertViewModel : Int , CaseIterable, CustomStringConvertible  {
    case most
    case littleChange
    case mostChange
    
    var description: String {
        switch self {
        case .most:
            return "인기 순 "
        case .littleChange:
            return "변화량이 높은 순"
        case .mostChange:
            return "변화량이 많은 순 "
        }
    }
}
