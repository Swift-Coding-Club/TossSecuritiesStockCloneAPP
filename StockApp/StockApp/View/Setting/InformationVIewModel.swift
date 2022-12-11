//
//  InformationVIewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/20.
//

import Foundation

enum InformationVIewModel : Int , CaseIterable, CustomStringConvertible {
    case termsOfService
    case personalInformation
    case developer
   
    var description: String {
        
        switch self {
        case.termsOfService:
            return "이용약관"
        case .personalInformation:
            return "개인정보 처리 방침"
        case .developer:
            return "개발자 정보"
        }
        
    }
    
    var imageName: String {
        switch self {
        case .termsOfService:
            return "list.bullet.clipboard"
        case .personalInformation:
            return "personal"
        case .developer:
            return "developer"
        }
    }
    
}
