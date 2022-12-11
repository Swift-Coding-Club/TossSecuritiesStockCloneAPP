//
//  StockModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/26.
//

import Foundation

// MARK: - Response
struct StockModel: Codable {
    let quoteResponse: QuoteResponse?
}

// MARK: - QuoteResponse
struct QuoteResponse: Codable {
    let result: [QuoteResponseRow]?
    let error: ErrorResponse?
}

// MARK: - Result
struct QuoteResponseRow: Codable {
    let language, region, quoteType, typeDisp: String?
    let quoteSourceName: String?
    let triggerable: Bool?
    let customPriceAlertConfidence, currency, marketState: String?
    let regularMarketChangePercent, regularMarketPrice: Double?
    let priceHint: Int?
    let postMarketChangePercent: Double?
    let postMarketTime: Int?
    let postMarketPrice, postMarketChange, regularMarketChange: Double?
    let regularMarketTime: Int?
    let regularMarketDayHigh: Double?
    let regularMarketDayRange: String?
    let regularMarketDayLow: Double?
    let regularMarketVolume: Double?
    let regularMarketPreviousClose, bid, ask: Double?
    let bidSize, askSize: Int?
    let fullExchangeName, financialCurrency: String?
    let regularMarketOpen: Double?
    let averageDailyVolume3Month, averageDailyVolume10Day: Int?
    let fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: Double?
    let fiftyTwoWeekRange: String?
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh: Double?
    let dividendDate, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd: Int?
    let trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield: Double?
    let firstTradeDateMilliseconds: Int?
    let exchange, shortName, longName, messageBoardID: String?
    let exchangeTimezoneName, exchangeTimezoneShortName: String?
    let gmtOffSetMilliseconds: Int?
    let market: String?
    let esgPopulated: Bool?
    let epsTrailingTwelveMonths, epsForward, epsCurrentYear, priceEpsCurrentYear: Double?
    let sharesOutstanding: Int?
    let bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent: Double?
    let twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double?
    let marketCap: Int?
    let forwardPE, priceToBook: Double?
    let sourceInterval, exchangeDataDelayedBy: Int?
    let averageAnalystRating: String?
    let tradeable, cryptoTradeable: Bool?
    let displayName, symbol: String?

    enum CodingKeys: String, CodingKey {
        case language, region, quoteType, typeDisp, quoteSourceName, triggerable, customPriceAlertConfidence, currency, marketState, regularMarketChangePercent, regularMarketPrice, priceHint, postMarketChangePercent, postMarketTime, postMarketPrice, postMarketChange, regularMarketChange, regularMarketTime, regularMarketDayHigh, regularMarketDayRange, regularMarketDayLow, regularMarketVolume, regularMarketPreviousClose, bid, ask, bidSize, askSize, fullExchangeName, financialCurrency, regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh, dividendDate, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd, trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield, firstTradeDateMilliseconds, exchange, shortName, longName
        case messageBoardID = "messageBoardId"
        case exchangeTimezoneName, exchangeTimezoneShortName, gmtOffSetMilliseconds, market, esgPopulated, epsTrailingTwelveMonths, epsForward, epsCurrentYear, priceEpsCurrentYear, sharesOutstanding, bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent, marketCap, forwardPE, priceToBook, sourceInterval, exchangeDataDelayedBy, averageAnalystRating, tradeable, cryptoTradeable, displayName, symbol
    }
}
