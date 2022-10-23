//
//  InformationVIewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/20.
//

import Foundation

enum InformationVIewModel : Int , CaseIterable, CustomStringConvertible {
    case developer
    case personalInformation
    
    var description: String {
        
        switch self {
        case .developer:
            return "개발자"
        case .personalInformation:
            return "개인정보 처리 방침"
        }
        
    }
    
    var imageName: String {
        switch self {
        case .developer:
            return "developer"
            
        case .personalInformation:
            return "personalInformation"
        }
    }
    
}
