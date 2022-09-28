//
//  StatisticModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/25.
//

import Foundation

//MARK: - 통계 모델
struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
