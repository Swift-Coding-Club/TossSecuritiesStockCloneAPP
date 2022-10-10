//
//  CryptoDetailViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/01.
//

import SwiftUI
import Combine

class CryptoDetailViewModel: ObservableObject {
    
    @Published var overViewStatistics: [StatisticModel] = [ ]                    // 코인 개요 구독
    @Published var additionalStatistics: [StatisticModel] = [  ]               // 추가 세부 사항
    @Published var coinDescription: String? = nil                                    // 코인 자세한 설명
    @Published var webSiteURL: String? = nil                                           // 웹사이트 url
    @Published var redditURL: String? = nil                                           // 코인 페이지 관련 url
    //MARK: - 코인 디테일 서비스 관련
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailSetvice
    private var cancelables = Set <AnyCancellable>()                  // 구독 취소하는 변수
    
    //MARK: - 코인 데이터 서비스 초기화하고 coin 적용
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailSetvice(coin: coin)
        self.addSubscribers()
    }
    //MARK:  - viewModel 구독 추가 부분
    func addSubscribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataStatistics)
            .sink { [weak self] (returnedCoinsArrays) in
                debugPrint("코인 디테일 관련  데이터 로딩")
                self?.overViewStatistics = returnedCoinsArrays.overView
                self?.additionalStatistics = returnedCoinsArrays.additional
                debugPrint("\(returnedCoinsArrays)")
            }
            .store(in: &cancelables)
    
        //MARK:  - 코인 설명 에 관련 한 데이터
        coinDetailService.$coinDetail
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.webSiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancelables)
    }
    
    //MARK: - 코인 개용 및 세부 사항 관련
    private func mapDataStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overView: [StatisticModel], additional: [StatisticModel] ) {
        let overViewArray = createOverViewArray(coinModel: coinModel)
        let additonalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        return (overViewArray  , additonalArray)
    }
    //MARK: - 코인 개요 생성 함수
    private func createOverViewArray(coinModel: CoinModel) -> [StatisticModel]{
        //MARK: - 코인 개요
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()   // 코인 가격
        let pricePercentChange = coinModel.priceChangePercentage24H             // 코인 환율
        let priceStat = StatisticModel(title: "코인 시세", value: price, percentageChange: pricePercentChange)
        //MARK: - 시가 총액
        let marketCap = "KRW " + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")   // 마켓  시세
        let marketCapPercentChange =  coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "시가 총액", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "코인 순위", value: rank)
        
        let volume = "KRW " +  (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "시세", value: volume)
        
        let overViewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overViewArray
    }
    //MARK: - 코인 세부 사항 생성 함수
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        //MARK:  - 추가 세부사항 통계
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "코인 최고가", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "코인 최저가", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith2Decimals() ??  "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24시간 변화량", value: priceChange, percentageChange: pricePercentChange)
        
        let markertCapChange = "KRW " + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24시간 시가 총액", value: markertCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime  = coinDetailModel?.blockTimeInMinutes ?? .zero
        let blockTimeString = blockTime ==  .zero ? "n/a"  :  "\(blockTime)"
        let blockStat = StatisticModel(title: "blockTime", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hsahingStat = StatisticModel(title: "Hashing Algorthim", value: hashing)
        
        let additonalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat,hsahingStat
        ]
        return additonalArray
    }
}
