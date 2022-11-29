//
//  Utils.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation

struct Utils {
    
    //MARK: - 주식 단위 절사
    static var numberFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency  // 숫자 스타일
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ","
//        formatter.locale = .current   // 국가 관련
//        formatter.currencyCode = "krw"
//        formatter.currencySymbol = "KRW"
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 2
        return formatter
    }

    static func stockFormat(value: Double?) -> String? {
        guard let value,
              let text = numberFormatter.string(from: NSNumber(value: value))
        else { return nil }
        return text
    }
}
