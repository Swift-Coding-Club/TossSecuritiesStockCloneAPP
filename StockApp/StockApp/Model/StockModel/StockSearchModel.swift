//
//  StockSearchModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/27.
//

import Foundation

struct StockSearchModel: Codable {
    let count: Int?
    let quotes: [SearchQuote]?
    let news: [News]?
    let totalTime, timeTakenForQuotes, timeTakenForNews, timeTakenForAlgowatchlist: Int?
    let timeTakenForPredefinedScreener, timeTakenForCrunchbase, timeTakenForNav, timeTakenForResearchReports: Int?
    let timeTakenForScreenerField, timeTakenForCulturalAssets: Int?
}

// MARK: - News
struct News: Codable {
    let uuid, title, publisher: String?
    let link: String?
    let providerPublishTime: Int?
    let type: String?
    let thumbnail: Thumbnail?
    let relatedTickers: [String]?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let resolutions: [Resolution]?
}

// MARK: - Resolution
struct Resolution: Codable {
    let url: String?
    let width, height: Int?
    let tag: Tag?
}

enum Tag: String, Codable {
    case original = "original"
    case the140X140 = "140x140"
}

// MARK: - Quote
struct SearchQuote: Codable {
    let exchange, shortname, quoteType, symbol: String?
    let index: String?
    let score: Int?
    let typeDisp, longname, exchDisp, sector: String?
    let industry: String?
    let dispSECIndFlag, isYahooFinance: Bool?

    enum CodingKeys: String, CodingKey {
        case exchange, shortname, quoteType, symbol, index, score, typeDisp, longname, exchDisp, sector, industry
        case dispSECIndFlag = "dispSecIndFlag"
        case isYahooFinance
    }
}
