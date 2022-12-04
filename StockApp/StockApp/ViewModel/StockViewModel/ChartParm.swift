//
//  ChartParm.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import Foundation

enum ChartRangeParm: Int, CaseIterable, CustomStringConvertible {
    case oneday, oneWeek,oneMonth, threeMonth, sixMonth
    case YTD, oneYear, twoYear, fithYear, tenYear, all
    
    var description: String {
        switch self {
        case .oneday:
            return "1d"
        case .oneWeek:
            return "1w"
        case .oneMonth:
            return "1m"
        case .threeMonth:
            return "3m"
        case .sixMonth:
            return "6m"
        case .YTD:
            return "YTD"
        case .oneYear:
            return "1Y"
        case .twoYear:
            return "2Y"
        case .fithYear:
            return "5Y"
        case .tenYear:
            return "10Y"
        case .all:
            return "ALL"
        }
    }
}

enum ChartintervalParm: Int,CaseIterable, CustomStringConvertible {
    case oneMin, twoMin , fithMin, fiftennMin, thirtyMin, sixtyMin
    case oneHour, oneDay, fiveDay, oneWeek, oneMonth, threeMonth
    
    var description: String {
        switch self {
        case .oneMin:
            return "1m"
        case .twoMin:
            return "2m"
        case .fithMin:
            return "5m"
        case .fiftennMin:
            return "15m"
        case .thirtyMin:
            return "30m"
        case .sixtyMin:
            return "60m"
        case .oneHour:
            return "1h"
        case .oneDay:
            return "1d"
        case .fiveDay:
            return "5d"
        case .oneWeek:
            return "1wk"
        case .oneMonth:
            return "1mo"
        case .threeMonth:
            return "3mo"
        }
    }
}

enum ChartindicatorsParm: Int, CaseIterable,CustomStringConvertible {
    case quote
    
    var description: String {
        switch self {
        case .quote:
            return "quote"
        }
    }
}
