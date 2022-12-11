//
//  HomeCoinConverTitleViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/08.
//

import Foundation

enum HomeCoinConverTitleViewModel: Int, CustomStringConvertible, CaseIterable {
    case coinList
    case myCoin
    
    var description: String {
        switch self {
        case .coinList:
            return "코인 리스트"
        case .myCoin:
            return "보유한  코인"
        }
    }
}
