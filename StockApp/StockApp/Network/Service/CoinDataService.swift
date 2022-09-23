//
//  CoinDataService.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/23.
//

import Combine
import Alamofire

class CoinDataService {
    
    @Published var allcoins:  [CoinModel] = [ ]  //allcoin을  통해서 접근해서 사용
    var cancellabels = Set<AnyCancellable>()    // 구독 취소 하는 변수
    
    var coinSubscription: AnyCancellable?
    
     init() {
        getCoins()
    }
    
    //MARK:  - 데이터 통신 부분
    private func getCoins() {
        guard let url = URL(string: URLManger.coinUrl) else { return }
        
       coinSubscription =   URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return  output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("'데이터 통신 : success'")
                case .failure(let error):
                    debugPrint("데이터 통신 에러 : \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (returnedCoins)in
                self?.allcoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}
