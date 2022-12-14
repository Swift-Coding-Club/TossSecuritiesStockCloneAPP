//
//  NetworkingError.swift
//  StockApp
//
//  Created by μμμ§ on 2022/09/24.
//

import Foundation

enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknwon
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url: let url):
            return "[ π₯ ] μλͺ»λ  νΈμΆμ URL μλλ€ μ λλ‘ νμΈ ν΄μ λ€μ URLμ μ¨μ£ΌμΈμ \(url)"
        case .unknwon:
            return " [ β οΈ ] Unknown  error ocurred"
        }
    }
}
