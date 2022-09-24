//
//  NetworkingManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/24.
//

import Foundation
import Combine

class NetworkingManger {
    //MARK:  - url download 함수
    static func downloadUrl(url: URL) ->AnyPublisher<Data, Error>  {
       return URLSession.shared.dataTaskPublisher(for: url)
             .subscribe(on: DispatchQueue.global(qos: .default))
             .tryMap({ try handleURLResponse(output: $0, url: url) })
             .receive(on: DispatchQueue.main)
        //MARK:  - 어떤 구독인지  사용할수 있게 가능
             .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return  output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            debugPrint("'데이터 통신 : success'")
        case .failure(let error):
            debugPrint("데이터 통신 에러 : \(error.localizedDescription)")
        }
    }
}
