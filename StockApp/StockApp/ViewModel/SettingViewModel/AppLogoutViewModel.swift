//
//  SideMenuVIewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/19.
//

import Foundation

enum AppLogoutViewModel: Int,  CaseIterable, CustomStringConvertible {
    case logout
    
    var description: String {
        switch self {
        case .logout:
            return "로그아웃 "
        }
    }
    
    var imageName: String {
        switch self {
        case .logout:
            return "rectangle.portrait.and.arrow.forward"
        }
    }
    
}
