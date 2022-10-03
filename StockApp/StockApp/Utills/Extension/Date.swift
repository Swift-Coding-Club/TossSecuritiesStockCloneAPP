//
//  Data.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/03.
//

import Foundation

extension Date {
    
    init(coinGeokoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeokoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    //MARK: - 날짜 짧게
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
