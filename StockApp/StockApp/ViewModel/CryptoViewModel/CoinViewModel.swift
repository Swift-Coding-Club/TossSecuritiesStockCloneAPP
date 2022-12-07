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
    @Published var portfolioStatistic: [StatisticModel] = [ ]
    @Published var allCoins: [CoinModel] = [ ]
    @Published var profilioCoins : [CoinModel] =  [ ]
    @Published var searchText: String = ""                                      // 검색 관련
    @Published var isLoading: Bool = false                                      // 로딩 관련
    @Published var sortOption: SortOption   = .holdings                   //  정렬  관련
    
    private let coinDataService = CoinDataService()                    // 코인 데이터 서비스 변수
    private let marketDataService = CoinMarketDataService()
    private let portfolioDataService = PortfolioDataService()   //  보유 수량 데이터 서비스
    private var cancelables = Set <AnyCancellable>()                  // 구독 취소하는 변수
    
    //MARK:  - 데이터 받아 오기전 초기화
    init() {
        addSubscribers()
    }
    
    //MARK:  - viewModel 구독 추가 부분
    func addSubscribers() {
        //MARK:  - update allcoins
        $searchText
            .combineLatest(coinDataService.$allcoins, $sortOption)        //데이터 서비스에서 모든 코인을 수신하면, 정렬 관련
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)      // 빠르게 입력할때  0.5 초동안  지연
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        //MARK:  - 보유 수량 데이터 업데이트
        $allCoins
            .combineLatest(portfolioDataService.$savedEntites)
            .map(mapAllcoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoin) in
                debugPrint("[🔥] DEBUG : 코인 리스트  : \(returnedCoin)")
                guard let self = self else { return }
                self.profilioCoins = self.sortPortfolioCoinsNeed(coins: returnedCoin)
            }
            .store(in: &cancelables)
        
        //MARK: - 마켓 데이터 업데이트
        marketDataService.$marketData
            .combineLatest($profilioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                debugPrint("[🔥] DEBUG : 마켓  리스트  :  \(returnedStats)")
                self?.statistic = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancelables)
        
        marketDataService.$portfolioData
            .combineLatest($profilioCoins)
            .map(mapPortfolioData)
            .sink { [weak self] (returnedStatsPortfolio) in
                debugPrint("[🔥] DEBUG : 보유 하고 있는 코인 마켓 리스트  :  \(returnedStatsPortfolio)")
                self?.portfolioStatistic = returnedStatsPortfolio
                self?.isLoading = false
            }
            .store(in: &cancelables)
    }
    //MARK: - 보유 수량 update
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    //MARK: - 데이터 리로드
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManger.notification(type: .success)
    }
    //MARK:  - 검색 과 정렬 관련
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel]  {
        var fillerCoins = fillterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &fillerCoins)            // 코인 정렬 및  fillter coin을 구독
        return fillerCoins
    }
    //MARK: - 검색창 필터
    private func fillterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        // 텍스트 대문자 또는 소문자로 입력 하면 인식
        let lowerCasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText)
        }
    }
    //MARK:  - 코인 정렬
    private func sortCoins(sort: SortOption, coins: inout [CoinModel])  {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    //MARK: - 마켓 데이터
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = [ ]
        
        guard let data = marketDataModel else {
            return stats
        }
        //MARK: - 마켓 cap
        let marketCap = StatisticModel(title: "시가 총액", value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        //MARK: - 24시간 코인 시세
        let volume = StatisticModel(title: "24시간 코인 시세", value: data.volume)
        //MARK: - 비트 코인 시세
        let btcDomainance = StatisticModel(title: "비트코인 시세", value: data.btcDominance)
        //MARK: - 보유 수량
        let portfolioValue = portfolioCoins.map({ $0.currentHoldingsValue})
            .reduce(.zero, +)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? .zero) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(.zero, +)
        
        //MARK:  - 보유 수량 %
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "총 보유 수량 ",
            value: portfolioValue.asCurrencyWith2DecimalsValue(),
            percentageChange: percentageChange)
        //MARK:- StatisticModel에 append
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDomainance,
        ])
        return stats
    }
    
    private func mapPortfolioData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = [ ]
        
        //MARK: - 보유 수량
        let portfolioValue = portfolioCoins.map({ $0.currentHoldingsValue})
            .reduce(.zero, +)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? .zero) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(.zero, +)
        //MARK:  - 보유 수량 %
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: " 총 보유 수량 ",
            value: portfolioValue.asCurrencyWith2DecimalsValue(),
            percentageChange: percentageChange)
        //MARK:- StatisticModel에 append
        stats.append(contentsOf: [
            portfolio
        ])
        return stats
    }
    
    //MARK: - 모든 코인 map
    private func mapAllcoinsToPortfolioCoins(allcoins: [CoinModel], portfolioEntites: [PortfolioEntity]) -> [CoinModel] {
        allcoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntites.first(where:  {$0.coinId == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    //MARK:  - 보유 수량 정렬
    private func sortPortfolioCoinsNeed(coins: [CoinModel]) -> [CoinModel] {
        // 자신이 보유 한 코인들만  정렬
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }
}
