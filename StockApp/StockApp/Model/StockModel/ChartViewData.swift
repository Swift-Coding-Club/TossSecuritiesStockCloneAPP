//
//  ChartViewData.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/05.
//

import Foundation
import SwiftUI

struct ChartViewData: Identifiable {
    let id = UUID()
    let xAxisData: ChartAxisData
    let yAxisData: ChartAxisData
    let itmes: [ChartViewItem]
    let lineColor: Color
    let previousCloseRuleMarkValue: Double?
}


