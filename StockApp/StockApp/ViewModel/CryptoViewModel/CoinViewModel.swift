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
    
    @Published var statistic: [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 1),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value", percentageChange: -7),
    ]
    

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
        //MARK:  - update allcoins
        $searchText
            .combineLatest(dataService.$allcoins)        //데이터 서비스에서 모든 코인을 수신하면
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)      // 빠르게 입력할때  0.5 초동안  지연
            .map(fillterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
    }
    
    private func fillterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        // 텍스트 대문자 또는 소문자로 입력 하면 인식
        let lowerCasedText = text.lowercased()
        return coins.filter { (coin)  -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText)
        }
    }
    
}
