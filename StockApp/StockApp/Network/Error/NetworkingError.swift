//
//  NetworkingError.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/24.
//

import Foundation

enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknwon
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url: let url):
            return "[ 🔥 ] 잘못된  호출의 URL 입니다 제대로 확인 해서 다시 URL을 써주세요 \(url)"
        case .unknwon:
            return " [ ⚠️ ] Unknown  error ocurred"
        }
    }
}
