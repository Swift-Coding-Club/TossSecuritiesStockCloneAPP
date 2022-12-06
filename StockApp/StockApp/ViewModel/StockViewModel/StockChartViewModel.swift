//
//  StockChartViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/05.
//

import Foundation
import Charts
import SwiftUI
import XCAStocksAPI


@MainActor
@available(iOS 16.0, *)
class StockChartViewModel: ObservableObject {
    
    var chart : ChartViewData? { fetchPhase.value }
    let ticker: Ticker
    let stockAPI: StockApIService
    
    @AppStorage("selectedRange") private var _range = ChartRange.oneDay.rawValue
    @Published var fetchPhase = FetchPhase<ChartViewData>.initial
    @Published var selectedRange = ChartRange.oneDay {
        didSet {
            _range = selectedRange.rawValue
        }
    }
    
    @Published var selectedX: ( any Plottable)?
    
    var selectedXRuleMark: (value: Date, text: String)? {
        guard let selectedX = selectedX as? Date, let chart else { return nil }
        let index = DateBins(thresholds: chart.itmes.map { $0.timestamp } ).index(for: selectedX)
        return (selectedX, String(format: "%.2f",  chart.itmes[index].value))
    }
    
    var forgroundMarkColor: Color {
        (selectedX != nil) ? Color.colorAssets.skyblue4.opacity(0.8) : (chart?.lineColor ?? Color.colorAssets.skyblue4.opacity(0.8))
    }
    
    private let selectedValueDateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    var selectedXDateText: String {
        guard let selectedX = selectedX as? Date,  let chart else { return "" }
        if selectedRange == .oneDay || selectedRange == .oneWeek {
            selectedValueDateFormatter.timeStyle = .short
        } else {
            selectedValueDateFormatter.timeStyle = .none
        }
        let index = DateBins(thresholds: chart.itmes.map { $0.timestamp }).index(for: selectedX)
        let item = chart.itmes[index]
        return selectedValueDateFormatter.string(from: item.timestamp)
    }
    
    var selectedXOpacity: Double {
        selectedX == nil ? 1 : .zero
    }
    
    init(ticker: Ticker, stockAPI: StockApIService = XCAStocksAPI()) {
        self.ticker = ticker
        self.stockAPI = stockAPI
        self.selectedRange = ChartRange(rawValue: _range) ?? .oneDay
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
    
    //MARK: - 차트 데이터 변화
    func transformChartViewData(_ data: ChartData) -> ChartViewData {
        let items = data.indicators.map { ChartViewItem(timestamp: $0.timestamp, value: $0.close)}
        let yAxisChartData = yAxisChartData(data)
        return ChartViewData(
            yAxisData: yAxisChartData,
            itmes: items,
            lineColor: getLineColor(data: data),
            previousCloseRuleMarkValue: previousCloseRuleMarkValue(data: data, yAxisData: yAxisChartData)
        )
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
    //MARK: - 차트 Yaxis 데이터
    func yAxisChartData(_ data: ChartData) -> ChartAxisData {
        let closes = data.indicators.map { $0.close }
        var  lowest = closes.min() ?? .zero
        var highest = closes.max() ?? .zero
        
        if let prevClose = data.meta.previousClose, selectedRange == .oneDay {
            if prevClose < lowest  {
              lowest = prevClose
            } else if prevClose > highest {
                highest = prevClose
            }
        }
        return ChartAxisData(
            axisStart: lowest + 0.01,
            axisEnd: highest + 0.01
        )
    }
    //MARK: - previousCloseRuleMarkValue
    
    func previousCloseRuleMarkValue(data: ChartData, yAxisData: ChartAxisData) -> Double? {
        guard let previousClose = data.meta.previousClose, selectedRange == .oneDay else {
            return nil
        }
        return (yAxisData.axisStart <= previousClose && previousClose <= yAxisData.axisEnd) ? previousClose : nil
    }

}
