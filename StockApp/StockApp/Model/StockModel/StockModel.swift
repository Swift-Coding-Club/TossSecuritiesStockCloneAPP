//
//  StockModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/06.
//

import Foundation

// MARK: - Response
struct StockMostModelResponse: Codable {
    let source: String?
    let start, count, total: Int?
    let responseDescription: String?
    let quotes: [StockMostModelResponseQuote]?

    enum CodingKeys: String, CodingKey {
        case source, start, count, total
        case responseDescription = "description"
        case quotes
    }
}

// MARK: - Quote
struct StockMostModelResponseQuote: Codable {
    let language: Language?
    let region: Region?
    let quoteType: QuoteType?
    let typeDisp: TypeDisp?
    let quoteSourceName: QuoteSourceName?
    let triggerable: Bool?
    let customPriceAlertConfidence: CustomPriceAlertConfidence?
    let currency: Currency?
    let regularMarketChangePercent, postMarketPrice, postMarketChange, regularMarketChange: Double?
    let regularMarketTime: Int?
    let regularMarketPrice, regularMarketDayHigh: Double?
    let regularMarketDayRange: String?
    let regularMarketDayLow: Double?
    let regularMarketVolume: Double?
    let regularMarketPreviousClose, bid, ask: Double?
    let bidSize, askSize: Int?
    let market: Market?
    let messageBoardID: String?
    let fullExchangeName: FullExchangeName?
    let longName: String?
    let financialCurrency: Currency?
    let regularMarketOpen: Double?
    let averageDailyVolume3Month, averageDailyVolume10Day: Int?
    let fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: Double?
    let fiftyTwoWeekRange: String?
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent: Double?
    let dividendDate: Int?
    let trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield: Double?
    let firstTradeDateMilliseconds, priceHint: Int?
    let postMarketChangePercent: Double?
    let postMarketTime: Int?
    let marketState: MarketState?
    let epsTrailingTwelveMonths, epsForward, epsCurrentYear, priceEpsCurrentYear: Double?
    let sharesOutstanding: Int?
    let bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent: Double?
    let twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double?
    let marketCap: Int?
    let forwardPE, priceToBook: Double?
    let sourceInterval, exchangeDataDelayedBy: Int?
    let exchangeTimezoneName: ExchangeTimezoneName?
    let exchangeTimezoneShortName: ExchangeTimezoneShortName?
    let gmtOffSetMilliseconds: Int?
    let averageAnalystRating: String?
    let esgPopulated, tradeable, cryptoTradeable: Bool?
    let exchange: Exchange?
    let fiftyTwoWeekLow, fiftyTwoWeekHigh: Double?
    let shortName, displayName, symbol: String?
    let earningsTimestamp, earningsTimestampStart, earningsTimestampEnd: Int?
    let ipoExpectedDate, prevName, nameChangeDate: String?

    enum CodingKeys: String, CodingKey {
        case language, region, quoteType, typeDisp, quoteSourceName, triggerable, customPriceAlertConfidence, currency, regularMarketChangePercent, postMarketPrice, postMarketChange, regularMarketChange, regularMarketTime, regularMarketPrice, regularMarketDayHigh, regularMarketDayRange, regularMarketDayLow, regularMarketVolume, regularMarketPreviousClose, bid, ask, bidSize, askSize, market
        case messageBoardID = "messageBoardId"
        case fullExchangeName, longName, financialCurrency, regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, dividendDate, trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield, firstTradeDateMilliseconds, priceHint, postMarketChangePercent, postMarketTime, marketState, epsTrailingTwelveMonths, epsForward, epsCurrentYear, priceEpsCurrentYear, sharesOutstanding, bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent, marketCap, forwardPE, priceToBook, sourceInterval, exchangeDataDelayedBy, exchangeTimezoneName, exchangeTimezoneShortName, gmtOffSetMilliseconds, averageAnalystRating, esgPopulated, tradeable, cryptoTradeable, exchange, fiftyTwoWeekLow, fiftyTwoWeekHigh, shortName, displayName, symbol, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd, ipoExpectedDate, prevName, nameChangeDate
    }
}

enum Currency: String, Codable {
    case brl = "BRL"
    case cny = "CNY"
    case usd = "USD"
}

enum CustomPriceAlertConfidence: String, Codable {
    case high = "HIGH"
    case low = "LOW"
}

enum Exchange: String, Codable {
    case nms = "NMS"
    case nyq = "NYQ"
}

enum ExchangeTimezoneName: String, Codable {
    case americaNewYork = "America/New_York"
}

enum ExchangeTimezoneShortName: String, Codable {
    case est = "EST"
}

enum FullExchangeName: String, Codable {
    case nasdaqGS = "NasdaqGS"
    case nyse = "NYSE"
}

enum Language: String, Codable {
    case enUS = "en-US"
}

enum Market: String, Codable {
    case usMarket = "us_market"
}

enum MarketState: String, Codable {
    case closed = "CLOSED"
}

enum QuoteSourceName: String, Codable {
    case delayedQuote = "Delayed Quote"
    case nasdaqRealTimePrice = "Nasdaq Real Time Price"
}

enum QuoteType: String, Codable {
    case equity = "EQUITY"
}

enum Region: String, Codable {
    case us = "US"
}

enum TypeDisp: String, Codable {
    case equity = "Equity"
}
