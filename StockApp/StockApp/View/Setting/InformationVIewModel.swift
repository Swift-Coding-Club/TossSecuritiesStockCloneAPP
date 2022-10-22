//
//  InformationVIewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/20.
//

import Foundation

enum InformationVIewModel : Int , CaseIterable, CustomStringConvertible {
    case developer
    
    var description: String {
        
        switch self {
        case .developer:
            return "개발자"
        }
    }
    
    var imageName: String {
        switch self {
        case .developer:
            return "developer"
        }
    }
    
}
