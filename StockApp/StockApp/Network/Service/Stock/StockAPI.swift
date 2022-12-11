//
//  StockAPI.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/15.
//

import Foundation
import Combine
import Alamofire

enum StockAPI {
    static let agent = Agent()
    static var stockBaseURL : URL {
        return URL(string: "https://query1.finance.yahoo.com")!
    }
    
    static var stockOverViewURL: URL {
        return URL(string: "https://www.alphavantage.co")!
    }
    
    static var cryptoBaseURL: URL {
        return URL(string: "https://api.coingecko.com/")!
    }
    
    static func headers() -> HTTPHeaders {
        return [
            
//            "content-type": "application/json; charset=utf-8",
//            "X-Mboum-Secret": SecretKey.stockSecretKey
            ]
    }
}

extension StockAPI {
    static func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
        print("url : \(url), params : ")
        let request = AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers())
        
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func get<T: Decodable, P: Encodable>(_ url: URL, parameters: P) -> AnyPublisher<T, APIError> {
        print("url : \(url), params : \(parameters)")
        let request = AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString), headers: headers())
        
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func post<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
        print("url : \(url), params : ")
        let request = AF.request(url, method: .post, encoding: URLEncoding.default, headers: headers())
        
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func post<T: Decodable>(_ url: URL, parameters: [String: String]) -> AnyPublisher<T, APIError> {
        print("url : \(url), params : \(parameters)")
        let request = AF.request(url, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: headers())
        return agent.run(request)
        .map(\.value)
        .eraseToAnyPublisher()
    }
    
    static func post<T: Decodable, P: Encodable>(_ url: URL, parameters: P) -> AnyPublisher<T, APIError> {
        print("url : \(url), params : \(parameters)")
        let request = AF.request(url, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: headers())
        return agent.run(request)
        .map(\.value)
        .eraseToAnyPublisher()
    }
}
