//
//  FeedBackViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/11.
//

import Foundation

enum FeedBackViewModel: Int, CaseIterable , CustomStringConvertible{
    case sendEmail
    
    var description: String {
        switch self {
        case .sendEmail:
            return "메일 보내기"
        }
    }
    
    var imageName: String {
        switch self {
        case .sendEmail:
            return "envelope"
        }
    }
}
