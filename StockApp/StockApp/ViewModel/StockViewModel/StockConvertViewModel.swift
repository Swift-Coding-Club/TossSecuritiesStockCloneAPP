//
//  StockConvertViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import Foundation

enum StockConvertViewModel : Int , CaseIterable, CustomStringConvertible  {
    case most
    case increase
    case littleChange
    case largeChange
    
    var description: String {
        switch self {
        case .most:
            return "인기 순 "
        case .increase:
            return "주식이 상승률"
        case .littleChange:
            return "변화량이 적은 순"
        case .largeChange:
            return "변화량이 많은 순 "
        }
    }
}
