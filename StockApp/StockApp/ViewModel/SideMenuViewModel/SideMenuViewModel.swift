//
//  SideMenuVIewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/19.
//

import Foundation

enum SideMenuViewModel: Int,  CaseIterable, CustomStringConvertible {
    case home
    case stock
    case nft
    case crypto
    case profile
    case Logout
    
    var description: String {
        switch self {
        case .home:
            return "홈"
        case .stock:
            return "주식"
        case .nft:
            return "NFT"
        case .crypto:
            return "코인"
        case .profile:
            return "프로필"
        case .Logout:
            return "로그아웃 "
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .stock:
            return "chart.bar.fill"
        case .nft:
            return "plus.circle.fill"
        case .crypto:
            return "dollarsign.circle.fill"
        case .profile:
            return "person.fill"
        case .Logout:
            return "rectangle.portrait.and.arrow.forward"
        }
    }
    
}
