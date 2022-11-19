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
    
    static func headers() -> HTTPHeaders {
        return [
            "X-RapidAPI-Key" : "4886dc5b19msh2a9924cfca7e122p111b80jsn8dd7d40f51ac",
            "X-RapidAPI-Host" : "apidojo-yahoo-finance-v1.p.rapidapi.com"
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
