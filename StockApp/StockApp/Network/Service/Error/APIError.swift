//
//  APIError.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/15.
//

import Foundation

enum APIError: Error {
    case http(ErrorData)
    case unknown
}

struct ErrorData: Codable {
    var code: String
    var message: String
    var data: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(String?.self, forKey: .code) ?? "9999"
        message = try container.decode(String?.self, forKey: .message) ?? "parsing error"
        data = nil
    }
}
