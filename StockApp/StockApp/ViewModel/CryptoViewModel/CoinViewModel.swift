//
//  CoinViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/21.
//

import Foundation
import Combine

// ObservableObject 로 뷰를 관찰및 접근
class CoinViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = [ ]
    @Published var profilioCoins : [CoinModel] =  [ ]
    @Published var searchText: String = "" // 검색 관련
    
    private let dataService = CoinDataService()         // 데이터 서비스 변수
    private var cancelables = Set <AnyCancellable>()   // 구독 취소하는 변수
    
    //MARK:  - 데이터 받아 오기전 초기화
    init() {
        addSubscribers()
    }
    
    //MARK:  - 데이터 통신 하는부분
    func addSubscribers() {
        dataService.$allcoins
            .sink {  [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
    }
}
