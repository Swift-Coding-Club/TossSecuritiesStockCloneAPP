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

struct getStockFininaceChartListParm: Codable {
    let range: String
    let interval: String
    let includeTimestamp: Bool
    let indicators:  String
}


extension StockAPI {
    //MARK: 주식 관련 리스트 가져오기
    static func getStockYahooListData(_ parm: getStockYahooDataListParm) -> AnyPublisher<StockModel, APIError>{
        return get(stockBaseURL.appendingPathComponent(URLManager.yahoofiniance), parameters: parm)
    }
    //MARK: - 검색 관련 api
    static func getStockSearchYahooListData(_ parm: getStockSearchYahooDataListParm) -> AnyPublisher<StockSearchModel, APIError> {
        return get(stockBaseURL.appendingPathComponent(URLManager.yahooFinianceSearch), parameters: parm)
    }
    
    //MARK:  - nsd 주식 데이터차트
    static func getStockNsdFinianceChartData(_ parm: getStockFininaceChartListParm) -> AnyPublisher<StockChartModel, APIError> {
        return get(stockBaseURL.appendingPathComponent(URLManager.yahooNsdFinianceChart), parameters: parm)
    }

    //MARK: - 뉴욕  주식 데이터 차트
    static func getStockNewtorkFinianceChartData(_ parm: getStockFininaceChartListParm) -> AnyPublisher<StockChartModel, APIError> {
        return get(stockBaseURL.appendingPathComponent(URLManager.yahooNewYorkFinianceChart), parameters: parm)
    }
}
