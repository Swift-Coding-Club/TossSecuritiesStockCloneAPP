//
//  URlManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/23.
//

import Foundation

struct URLManager {
    
    static let mainUrl: String = "https://api.coingecko.com"
    
    static let stockMainUrl: String = "https://yahoo-finance15.p.rapidapi.com"
    
    static let coinCatergory: String = "/api/v3/coins/"
    
    static let coinMartket: String = "api/v3/global"
    
    static let localiztaion: String = "ko"
    
    static let stockMarket: String = "co/collections/"
    
    static let stockMostMarket: String = ""
    
    static let stockSmallCapMarket: String = "/collections/small_cap_gainers"
    
    static let stockIncreaseCapMarket: String = "/collections/aggressive_small_caps"
    
    static let stockLargeCapMarket: String = "collections/undervalued_large_caps"
    
    static let coinURL: String = "\(mainUrl)\(coinCatergory)markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    static let coinMartURL: String = "\(mainUrl)\(coinMartket)"
    
    static let coinDetail : String  = "\(mainUrl)\(coinCatergory)bitcoin?localization=\(localiztaion)&tickers=true&market_data=false&community_data=false&developer_data=false&sparkline=false"
    
    static let stockUrl: String = "\(stockMainUrl)\(stockMarket)"
    
}
