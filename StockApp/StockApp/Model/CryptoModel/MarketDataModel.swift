//
//  MarketDataModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/26.
//

import Foundation

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    //MARK:  - 마켓의 종류줄  첫번째
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "krw"}) {
            return "KRW " + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    //MARK:  - 총가격
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "krw"}) {
            return "KRW " + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    //MARK: - 비트코인
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }    
}
