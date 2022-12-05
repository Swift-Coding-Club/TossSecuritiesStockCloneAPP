//
//  StockChartModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import Foundation

// MARK: - Response
struct StockChartModel: Codable {
    let chart: Charts?
}

// MARK: - Chart
struct Charts: Codable {
    let result: [StockChartRow]?
    let error: ErrorResponse?
}

// MARK: - Result
struct StockChartRow: Codable {
    let meta: Meta?
    let timestamp: [Int]?
    let indicators: Indicators?
}

// MARK: - Indicators
struct Indicators: Codable {
    let quote: [StockQuotes]?
}

// MARK: - Quote
struct StockQuotes: Codable {
    let close: [Double?]?
    let volume: [Int?]?
    let high, quoteOpen, low: [Double?]?

    enum CodingKeys: String, CodingKey {
        case close, volume, high
        case quoteOpen = "open"
        case low
    }
}

// MARK: - Meta
struct Meta: Codable {
    let currency, symbol, exchangeName, instrumentType: String?
    let firstTradeDate, regularMarketTime, gmtoffset: Int?
    let timezone, exchangeTimezoneName: String?
    let regularMarketPrice, chartPreviousClose, previousClose: Double?
    let scale, priceHint: Int?
    let currentTradingPeriod: CurrentTradingPeriod?
    let tradingPeriods: [[Post]]?
    let dataGranularity, range: String?
    let validRanges: [String]?
}

// MARK: - CurrentTradingPeriod
struct CurrentTradingPeriod: Codable {
    let pre, regular, post: Post?
}

// MARK: - Post
struct Post: Codable {
    let timezone: String?
    let start, end, gmtoffset: Int?
}

