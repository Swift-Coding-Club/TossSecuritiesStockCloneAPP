//
//  Double.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/21.
//

import Foundation

extension Double {
    
    //MARK:  -  코인 단위 관련  2자리 6자리
    private var currencyForatter6 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency // 숫자 스타일
        formatter.locale = .current   // 국가 관련
        formatter.currencyCode = "krw"
        formatter.currencySymbol = "KRW"
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 6
        return formatter
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
}
