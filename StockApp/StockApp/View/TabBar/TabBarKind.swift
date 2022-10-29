//
//  TabBarKind.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import Foundation

enum TabBarKind : String,  CaseIterable , Hashable, CustomStringConvertible {
    case home
    case stock
    case nft
    case crypto
    case profile 
    
    var description: String {
        switch self {
        case .home:
            return "house"
        case .stock:
            return "chart.bar"
        case .nft:
            return "plus.circle"
        case .crypto:
            return "dollarsign.circle"
        case .profile:
            return "person"
        }
    }
    
}
