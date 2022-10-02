//
//  CryptoDetailViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/01.
//

import SwiftUI
import Combine

class CryptoDetailViewModel: ObservableObject {
    
    //MARK: - 코인 디테일 서비스 관련
    let coin: CoinModel
    private let coinDetailService: CoinDetailSetvice
    private var cancelables = Set <AnyCancellable>()                  // 구독 취소하는 변수
    
    //MARK: - 코인 데이터 서비스 초기화하고 coin 적용
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailSetvice(coin: coin)
        self.addSubscribers()
    }

    func addSubscribers() {
        coinDetailService.$coinDetail
            .sink { (returnedCoinDetails) in
                debugPrint("코인 디테일 관련  데이터 로딩")
                debugPrint(returnedCoinDetails)
            
            }
            .store(in: &cancelables)
    }
}
