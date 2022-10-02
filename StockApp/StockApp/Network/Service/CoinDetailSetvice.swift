//
//  CoinDetailSetvice.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/01.
//

import SwiftUI
import Combine

class CoinDetailSetvice {
    
    @Published var coinDetail:  CoinDetailModel?  = nil //allcoin을  통해서 접근해서 사용
    
    //MARK: - 데이터 통신을 끝을경우 cancel 처리
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetail()
    }
    //MARK: - 코인  디데일 관련  통신
    func getCoinDetail() {
        guard let url  = URL(string: "\(URLManger.mainUrl)\(URLManger.coinCatergory)\(coin.id)?localization=\(URLManger.localiztaion)&tickers=true&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription =   NetworkingManger.downloadUrl(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedCoinDetail) in
                guard let self = self else { return }
                self.coinDetail = returnedCoinDetail
                self.coinDetailSubscription?.cancel()
            })
        
        
    }
}
