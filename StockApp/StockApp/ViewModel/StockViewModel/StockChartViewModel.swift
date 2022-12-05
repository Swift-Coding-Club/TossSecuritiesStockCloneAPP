//
//  StockChartViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/05.
//

import Foundation
import SwiftUI
import XCAStocksAPI

@MainActor
class StockChartViewModel: ObservableObject {
    
    @Published var fetchPhase = FetchPhase<ChartViewData>.initial
    var chart : ChartViewData? { fetchPhase.value }
    
    let ticker: Ticker
    let stockAPI: StockApIService
    
    @AppStorage("selectedRange") private var _range = ChartRange.oneDay.rawValue
    
    @Published var selectedRange = ChartRange.oneDay {
        didSet {
            _range = selectedRange.rawValue
        }
    }
    
    init(ticker: Ticker, stockAPI: StockApIService = XCAStocksAPI()) {
        self.ticker = ticker
        self.stockAPI = stockAPI
        self.selectedRange = ChartRange(rawValue: _range) ?? .oneDay
    }
    
    //MARK: - 차트 데이터 변화
    func transformChartViewData(_ data: ChartData) -> ChartViewData {
        let items = data.indicators.map { ChartViewItem(timestamp: $0.timestamp, value: $0.close)}
        return ChartViewData(
            itmes: items,
            lineColor: getLineColor(data: data)
        )
    }
    
    //MARK: - 차트 관련한 데이터 가져오기
    func fetchData()  async {
        do {
            fetchPhase = .fetching
            let rangeType = self.selectedRange
            let chartData = try await stockAPI.fetchChartData(tickerSymbol: ticker.symbol, range: rangeType)
            
            guard rangeType == self.selectedRange else { return }
            
            if let chartData {
                fetchPhase = .success(transformChartViewData(chartData))
            } else {
                fetchPhase = .empty
            }
            
        } catch {
            fetchPhase  = .failuer(error)
        }
    }
    //MARK: - 차트 라인 컬러
    func getLineColor(data: ChartData) -> Color {
        if let last = data.indicators.last?.close {
            if selectedRange == .oneDay, let prevClose = data.meta.previousClose {
                return last >= prevClose ? .green : .red
            } else if let first = data.indicators.first?.close {
                return last >= first ? .green : .red
            }
        }
        return Color.colorAssets.skyblue4.opacity(0.8)
    }
}
