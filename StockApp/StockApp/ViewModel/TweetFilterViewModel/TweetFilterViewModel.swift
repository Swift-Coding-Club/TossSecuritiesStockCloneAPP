//
//  TweetFilterViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/17.
//

import Foundation

enum TweetFilterViewModel: Int, CustomStringConvertible, CaseIterable {
    case tweets
    case replies
    case likes

    var description: String {
        switch self {
        case .tweets:
            return "트윗"
        case .replies:
            return "답변"
        case .likes:
            return "좋아요"
        }
    }
}
