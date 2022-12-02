//
//  Utils.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation

struct Utils {
    
    //MARK: - 주식 단위 절사
    static let numberFormatter : NumberFormatter =  {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency  // 숫자 스타일
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    static func stockFormat(value: Double?) -> String? {
        guard let value,
              let text = numberFormatter.string(from: NSNumber(value: value))
        else { return nil }
        return text
    }
    
    func asNumberString(value: Double?) -> String {
        return String(format: "%.2f", value ?? "") + "%"
    }
    
//   static func asPercentString() -> String {
//       return asNumberString(value: value) + "%"
//    }
    
}
