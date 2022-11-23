//
//  StockModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/06.
//

import Foundation

// MARK: - Response
struct StockModel : Codable {
    let meta: Meta?
    let data: StockResponse
}

struct StockResponse: Codable {
    let start, count, total: Int?
    let dataDescription: String?
    let quotes: [StockMostModelResponse]?

    enum CodingKeys: String, CodingKey {
        case start, count, total
        case dataDescription = "description"
        case quotes
    }
}


struct StockMostModelResponse: Codable {
    let language: Language?
        let region: Region?
        let quoteType: QuoteType?
        let typeDisp: TypeDisp?
        let quoteSourceName: QuoteSourceName?
        let triggerable: Bool?
        let customPriceAlertConfidence: CustomPriceAlertConfidence?
        let currency: Currency?
        let regularMarketChangePercent, regularMarketChange: Double?
        let regularMarketTime: Int?
        let regularMarketPrice, regularMarketDayHigh: Double?
        let regularMarketDayRange: String?
        let regularMarketDayLow: Double?
        let regularMarketVolume: Double?
        let regularMarketPreviousClose, bid, ask: Double?
        let bidSize, askSize: Int?
        let market: Market?
        let messageBoardID, fullExchangeName, longName, financialCurrency: String?
        let regularMarketOpen: Double?
        let averageDailyVolume3Month, averageDailyVolume10Day: Int?
        let fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: Double?
        let fiftyTwoWeekRange: String?
        let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent: Double?
        let earningsTimestamp, earningsTimestampStart, earningsTimestampEnd: Int?
        let trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield: Double?
        let firstTradeDateMilliseconds, priceHint: Int?
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
        let ipoExpectedDate, averageAnalystRating: String?
        let esgPopulated, tradeable, cryptoTradeable: Bool?
        let exchange: String?
        let fiftyTwoWeekLow, fiftyTwoWeekHigh: Double?
        let shortName, symbol: String?
        let dividendDate: Int?
        let displayName, prevName, nameChangeDate: String?

        enum CodingKeys: String, CodingKey {
            case language, region, quoteType, typeDisp, quoteSourceName, triggerable, customPriceAlertConfidence, currency, regularMarketChangePercent, regularMarketChange, regularMarketTime, regularMarketPrice, regularMarketDayHigh, regularMarketDayRange, regularMarketDayLow, regularMarketVolume, regularMarketPreviousClose, bid, ask, bidSize, askSize, market
            case messageBoardID = "messageBoardId"
            case fullExchangeName, longName, financialCurrency, regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd, trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield, firstTradeDateMilliseconds, priceHint, marketState, epsTrailingTwelveMonths, epsForward, epsCurrentYear, priceEpsCurrentYear, sharesOutstanding, bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent, marketCap, forwardPE, priceToBook, sourceInterval, exchangeDataDelayedBy, exchangeTimezoneName, exchangeTimezoneShortName, gmtOffSetMilliseconds, ipoExpectedDate, averageAnalystRating, esgPopulated, tradeable, cryptoTradeable, exchange, fiftyTwoWeekLow, fiftyTwoWeekHigh, shortName, symbol, dividendDate, displayName, prevName, nameChangeDate
        }
    }

    enum Currency: String, Codable {
        case usd = "USD"
    }

    enum CustomPriceAlertConfidence: String, Codable {
        case high = "HIGH"
        case low = "LOW"
    }

    enum ExchangeTimezoneName: String, Codable {
        case americaNewYork = "America/New_York"
    }

    enum ExchangeTimezoneShortName: String, Codable {
        case est = "EST"
    }

    enum Language: String, Codable {
        case enUS = "en-US"
    }

    enum Market: String, Codable {
        case usMarket = "us_market"
    }

    enum MarketState: String, Codable {
        case regular = "REGULAR"
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

    // MARK: - Meta
    struct Meta: Codable {
        let copyright, dataStatus: String?

        enum CodingKeys: String, CodingKey {
            case copyright
            case dataStatus = "data_status"
        }
    }
