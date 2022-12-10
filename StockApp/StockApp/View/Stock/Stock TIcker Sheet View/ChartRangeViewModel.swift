//
//  ChartRangeViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import Foundation
import XCAStocksAPI

extension ChartRange : Identifiable {
    public var id: Self { self}
    
    var title: String {
        switch self {
        case .oneDay:
            return "1일"
        case .oneWeek:
            return "1주"
        case .oneMonth:
            return "1달"
        case .threeMonth:
            return "3달"
        case .sixMonth:
            return "6달"
        case .ytd:
            return "YTD"
        case .oneYear:
            return "1년"
        case .twoYear:
            return "2년"
        case .fiveYear:
            return "5년"
        case .tenYear:
            return "10년"
        case .max:
            return "모두"
        }
    }
    
    var dateFormat: String {
        switch self {
        case .oneDay:
            return "H"
        case .oneWeek, .oneMonth:
        return "d"
        case .threeMonth, .sixMonth, .ytd:
            return "MMM"
        case .oneYear, .twoYear:
            return "MMMM"
        case .fiveYear, .tenYear, .max:
            return "yyyy"
        }
    }
    
    func getDateComponents(startDate: Date, endDate: Date, timezone: TimeZone) -> Set<DateComponents> {
        let component: Calendar.Component
        let value: Int
        switch self {
        case .oneDay:
            component = .hour
            value = 1
        case .oneWeek:
            component = .day
            value = 1
        case .oneMonth:
            component = .weekOfYear
            value = 1
        case .threeMonth, .sixMonth:
            component = .month
            value = 1
        case .ytd:
            component = .month
            value = 2
        case .oneYear:
            component = .month
            value = 4
        case .twoYear:
            component = .month
            value = 6
        case .fiveYear, .tenYear:
            component = .year
            value = 2
        case .max:
            component = .year
            value = 8
        }
        
        var set = Set<DateComponents>()
        var date = startDate
        if self != .oneDay {
            set.insert(startDate.dateComponents(timeZone: timezone, rangeType: self))
        }
        while date <= endDate {
            date = Calendar.current.date(byAdding: component, value: value , to: date) ?? Date()
            set.insert(date.dateComponents(timeZone: timezone, rangeType: self))
        }
        return set
    }
}

