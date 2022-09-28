//
//  CoinMarketDataService.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/26.
//

import Foundation
import Combine

class CoinMarketDataService {
    
    @Published var marketData:  MarketDataModel? = nil           //allcoin을  통해서 접근해서 사용
    var marketCoinSubscription: AnyCancellable?                  //구독 취소 하는 변수
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        guard let url = URL(string: URLManger.coinMartURL) else { return }
     
        marketCoinSubscription =   NetworkingManger.downloadUrl(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketCoinSubscription?.cancel()
            })
        
    }
}
