//
//  ProfileEditViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/11.
//

import Foundation

enum ProfileEditViewModel: Int , CaseIterable, CustomStringConvertible {
    case notice
    case profileEdit
    case appSetting
    
    var description: String {
        switch self {
        case .notice:
            return "공지사항"
        case .profileEdit:
            return "회원정보 수정"
        case .appSetting:
            return "환경설정"
        }
    }
    
    var imageName: String {
        switch self {
        case .notice:
            return "bell.fill"
        case .profileEdit:
            return "lock"
        case .appSetting:
            return "gearshape.fill"
        }
    }
}
