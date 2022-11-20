//
//  StockAPI-Market.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/19.
//

import Foundation
import Alamofire
import Combine

struct getStockDataParm: Codable {
    let start: Int
}


extension StockAPI {
    static func getStockData(_ parm: getStockDataParm) -> AnyPublisher<StockMostModelResponse, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.stockMarket), parameters: parm)
    }
}
