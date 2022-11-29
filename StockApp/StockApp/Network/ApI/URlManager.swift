//
//  URlManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/23.
//

import Foundation

struct URLManager {
    
    static let mainUrl: String = "https://api.coingecko.com"
    
    static let coinCatergory: String = "/api/v3/coins/"
    
    static let coinMartket: String = "api/v3/global"
    
    static let localiztaion: String = "ko"
    
    static let yahoofiniance: String = "/v7/finance/quote"
    
    static let yahooFinianceSearch: String = "/v1/finance/search"
    
    static let coinURL: String = "\(mainUrl)\(coinCatergory)markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    static let coinMartURL: String = "\(mainUrl)\(coinMartket)"
    
    static let coinDetail : String  = "\(mainUrl)\(coinCatergory)bitcoin?localization=\(localiztaion)&tickers=true&market_data=false&community_data=false&developer_data=false&sparkline=false"

}
