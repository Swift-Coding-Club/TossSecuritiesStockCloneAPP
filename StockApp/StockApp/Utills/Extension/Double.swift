//
//  Double.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/21.
//

import Foundation

extension Double {
    
    //MARK:  -  코인 단위 관련  1자리 6자리
    private var currencyForatter6 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency // 숫자 스타일
        formatter.locale = .current   // 국가 관련
        formatter.currencyCode = "krw"
        formatter.currencySymbol = "KRW"
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 8
        return formatter
    }

    private var currencyForatterValue: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency // 숫자 스타일
        formatter.locale = .current   // 국가 관련
        formatter.currencyCode = "kr"
        formatter.currencySymbol = ""
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 8
        return formatter
    }
    
    func asCurrencyWith2DecimalsValue() -> String {
        let number = NSNumber(value: self)
        return currencyForatterValue.string(from: number) ?? "0.00 KRW"
    }
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyForatter6.string(from: number) ?? "0.00 KRW"
    }
    
    private var currencyForatter2 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency  // 숫자 스타일
//        formatter.locale = .current   // 국가 관련
//        formatter.currencyCode = "krw"
//        formatter.currencySymbol = "KRW"
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 2
        return formatter
    }

    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyForatter6.string(from: number) ?? "0.00 KRW"
    }
    
    //MARK:  - % 관련
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    //MARK: - 단위 절사
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

}
