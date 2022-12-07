//
//  Agent.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/15.
//

import Foundation
import Combine
import Alamofire

struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, APIError> {
        return request.validate().publishData(emptyResponseCodes: [200, 201, 204, 205]).tryMap { result -> Response<T> in
            if let error = result.error {
                print(error)
                if let errorData = result.data {
                    let value = try decoder.decode(ErrorData.self, from: errorData)
                    throw APIError.http(value)
                }
                else {
                    throw error
                }
            }
            if let data = result.data {
//                print(String(decoding: data, as: UTF8.self))
                /*
                 json pretty log
                 */
                #if DEBUG
                if let request = request.request, let url = request.url {
                    print(String("\nurl: \(String(describing: url))"))
                }
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .withoutEscapingSlashes]) {
                    print(String(decoding: jsonData, as: UTF8.self) + "\n")
                } else {
                    print("json data malformed")
                }
                #endif
                
                do {
                    let value = try decoder.decode(T.self, from: data)
                    return Response(value: value, response: result.response!)
                } catch {
                    print(error)
                    let value = try decoder.decode(ErrorData.self, from: data)
                    throw APIError.http(value)
                }
            } else {
                return Response(value: Empty.emptyValue() as! T, response: result.response!)
            }
        }
        .mapError({ (error) -> APIError in
            if let apiError = error as? APIError {
                return apiError
            } else {
                return .unknown
            }
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
