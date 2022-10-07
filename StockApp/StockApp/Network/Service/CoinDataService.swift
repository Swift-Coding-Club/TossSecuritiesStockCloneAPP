//
//  CoinDataService.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/23.
//

import SwiftUI
import Combine

class CoinDataService {
    
    @Published var allcoins:  [CoinModel] = [ ]  //allcoin을  통해서 접근해서 사용
    
    var coinSubscription: AnyCancellable?
    
     init() {
        getCoins()
    }
    
    //MARK:  - 데이터 통신 부분
    func getCoins() {
        guard let url = URL(string: URLManger.coinURL) else { return }
        
        coinSubscription =   NetworkingManger.downloadUrl(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedCoins) in
                self?.allcoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
