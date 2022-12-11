//
//  ErrorResponse.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/27.
//

import Foundation

struct ErrorResponse: Codable {
    let code: String
    let description: String
    
    init(code: String, description:String) {
        self.code = code
        self.description = description
    }
}
