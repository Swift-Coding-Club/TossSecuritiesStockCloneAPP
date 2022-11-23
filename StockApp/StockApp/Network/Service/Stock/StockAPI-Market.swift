//
//  StockAPI-Market.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/19.
//

import Foundation
import Alamofire
import Combine

//MARK: - 주식 인기순
struct getStockDataParm: Codable {
    let start: Int
    let list: String
}
//MARK: - 주식 변화량이 적은
struct getStockSmallCapDataParm: Codable {
    let start: Int
    let list: String
}
//MARK:  - 주식 상승률 있는
struct getStockIncreaseCapDataParm: Codable {
    let start: Int
    let list: String
}
//MARK: - 주식 변화율이 큰
struct getStockLargeCapDataParm: Codable {
    let start: Int
    let list: String
}

extension StockAPI {
    //MARK: - 주식 인기순
    static func getStockData(_ parm: getStockDataParm) -> AnyPublisher<StockModel, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.stockMarket), parameters: parm)
    }
    //MARK: - 주식 변화량이 적은
    static func getStockSmallCapData(_ parm: getStockSmallCapDataParm) -> AnyPublisher<StockModel, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.stockSmallCapMarket), parameters: parm)
    }
    //MARK:  - 주식 상승률 있는
    static func getStockIncreaseCapData(_ parm: getStockIncreaseCapDataParm) -> AnyPublisher<StockModel, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.stockIncreaseCapMarket), parameters: parm)
    }
    //MARK: - 주식 변화율이 큰
    static func getStockLargeCapData(_ parm: getStockLargeCapDataParm) -> AnyPublisher<StockModel, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.stockLargeCapMarket), parameters: parm)
    }
}
