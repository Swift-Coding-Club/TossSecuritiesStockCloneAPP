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
    
    @Published var statistic: [StatisticModel] = [ ]
    
    
    @Published var allCoins: [CoinModel] = [ ]
    @Published var profilioCoins : [CoinModel] =  [ ]
    @Published var searchText: String = "" // 검색 관련
    
    private let coinDataService = CoinDataService()         // 코인 데이터 서비스 변수
    private let marketDataService = CoinMarketDataService()
    private var cancelables = Set <AnyCancellable>()   // 구독 취소하는 변수
    
    //MARK:  - 데이터 받아 오기전 초기화
    init() {
        addSubscribers()
    }
    
    //MARK:  - 데이터 통신 하는부분
    func addSubscribers() {
        //MARK:  - update allcoins
        $searchText
            .combineLatest(coinDataService.$allcoins)        //데이터 서비스에서 모든 코인을 수신하면
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)      // 빠르게 입력할때  0.5 초동안  지연
            .map(fillterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        //MARK: - 마켓 데이터 업데이트
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistic = returnedStats
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = [ ]
        
        guard let data = marketDataModel else {
            return stats
        }
        //MARK: - 마켓 cap
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        //MARK: - 24시간 코인 시세
        let volume = StatisticModel(title: "24시간  코인 시세", value: data.volume)
        //MARK: - 비트 코인 시세
        let btcDomainance = StatisticModel(title: "비트코인 시세", value: data.btcDominance)
        //MARK: - 보유 수량
        let portfolio = StatisticModel(title: "보유 수량 ", value: "0.00", percentageChange: .zero)
        //MARK:- StatisticModel에 append
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDomainance,
            portfolio
        ])
        return stats
    }
}
