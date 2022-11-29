//
//  StockAPI-Stock.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/19.
//

import Foundation
import Alamofire
import Combine

//MARK: - 야후 stock list
struct getStockYahooDataListParm: Codable {
    let symbols: String
}
//MARK: - 야휴 검색
struct getStockSearchYahooDataListParm: Codable {
    let q: String
}



extension StockAPI {
    static func getStockYahooListData(_ parm: getStockYahooDataListParm) -> AnyPublisher<StockModel, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.yahoofiniance), parameters: parm)
    }
    
    static func getStockSearchYahooListData(_ parm: getStockSearchYahooDataListParm) -> AnyPublisher<StockSearchModel, APIError> {
        return get(stockBaseURL.appendingPathComponent(URLManager.yahooFinianceSearch), parameters: parm)
    }
    
}
