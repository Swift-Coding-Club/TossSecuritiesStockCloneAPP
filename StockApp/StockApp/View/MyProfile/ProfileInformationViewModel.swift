//
//  ProfileInformationViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/10.
//

import Foundation

enum ProfileInformationViewModel: Int, CaseIterable , CustomStringConvertible {
    case appVersion
    
    var description: String {
        switch self {
        case .appVersion:
            return "버전 정보 "
        }
    }
}
