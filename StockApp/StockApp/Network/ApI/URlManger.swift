//
//  URlManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/23.
//

import Foundation

struct URLManger {
    
    static let coinURL: String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    static let coinMartURL: String = "https://api.coingecko.com/api/v3/global"
    
}
