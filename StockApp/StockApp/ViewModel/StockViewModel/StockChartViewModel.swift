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
    
    var selectedXRuleMark: (value: Int, text: String)? {
        guard let selectedX = selectedX as? Int, let chart else { return nil }
        return (selectedX,  chart.itmes[selectedX].value.roundedString)
    }
    
    var forgroundMarkColor: Color {
        (selectedX != nil) ? Color.colorAssets.skyblue4.opacity(0.8) : (chart?.lineColor ?? Color.colorAssets.skyblue4.opacity(0.8))
    }
    
    private let selectedValueDateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    private let dateFormatter = DateFormatter() 
    
    var selectedXDateText: String {
        guard let selectedX = selectedX as? Int,  let chart else { return "" }
        if selectedRange == .oneDay || selectedRange == .oneWeek {
            selectedValueDateFormatter.timeStyle = .short
        } else {
            selectedValueDateFormatter.timeStyle = .none
        }
        let item = chart.itmes[selectedX]
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
        let (xAxisChartData, items) = xAxisChartDataAndItems(data)
        let yAxisChartData = yAxisChartData(data)
        return ChartViewData(
            xAxisData: xAxisChartData,
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
    //MARK: - 차트 Xaxis 데이터
    func xAxisChartDataAndItems(_ data: ChartData) -> (ChartAxisData, [ChartViewItem]) {
        let timezone = TimeZone(secondsFromGMT: data.meta.gmtOffset) ?? .gmt
        dateFormatter.timeZone = timezone
        selectedValueDateFormatter.timeZone = timezone
        dateFormatter.dateFormat = selectedRange.dateFormat
        
        var xAxisDateComponents = Set<DateComponents>()
        if let startTimeStamp = data.indicators.first?.timestamp {
            if selectedRange == .oneDay {
                xAxisDateComponents = selectedRange.getDateComponents(startDate: startTimeStamp, endDate: data.meta.regularTradingPeriodEndDate, timezone: timezone)
            } else if let endTimeStamp = data.indicators.last?.timestamp {
                xAxisDateComponents = selectedRange.getDateComponents(startDate: startTimeStamp, endDate: endTimeStamp , timezone: timezone)
            }
        }
        var map = [String : String]()
        var axisEnd : Int
        var items = [ChartViewItem]()
        
        for(index, value) in data.indicators.enumerated() {
            let dateComponets = value.timestamp.dateComponents(timeZone: timezone, rangeType: selectedRange)
            
            if xAxisDateComponents.contains(dateComponets) {
                map[String(index)] = dateFormatter.string(from: value.timestamp)
                xAxisDateComponents.remove(dateComponets)
            }
            items.append(ChartViewItem(
                timestamp: value.timestamp,
                value: value.close))
        }
        axisEnd = items.count - 1
        
        
        if selectedRange == .oneDay,
           var date = items.last?.timestamp,
           date >= data.meta.regularTradingPeriodStartDate &&
           date < data.meta.regularTradingPeriodEndDate {
            while date < data.meta.regularTradingPeriodEndDate {
                axisEnd += 1
                date = Calendar.current.date(byAdding: .minute, value: 2, to: date)!
                let dc = date.dateComponents(timeZone: timezone, rangeType: selectedRange)
                if xAxisDateComponents.contains(dc) {
                    map[String(axisEnd)] = dateFormatter.string(from: date)
                    xAxisDateComponents.remove(dc)
                }
            }
        }
        
        let xAxisData = ChartAxisData(
            axisStart: .zero,
            axisEnd: Double(axisEnd),
            strideBy: 1,
            map: map)
        
        return (xAxisData, items)
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
        
        let diff = highest - lowest
        
        // 3
        let numberOfLines: Double = 4
        let shouldCeilIncrement: Bool
        let strideBy: Double
        
        if diff < (numberOfLines * 2) {
            // 4A
            shouldCeilIncrement = false
            strideBy = 0.01
        } else {
            // 4B
            shouldCeilIncrement = true
            lowest = floor(lowest)
            highest = ceil(highest)
            strideBy = 1.0
        }
        
        let increment = ((highest - lowest) / numberOfLines)
        var map = [String : String]()
        map[highest.roundedString] = formatYAxisValueLabel(value: highest, shouldCellIncrement: shouldCeilIncrement)
        
        var current = lowest
        (0..<Int(numberOfLines) - 1).forEach {  index in
            current += increment
            map[(shouldCeilIncrement ? ceil(current) : current).roundedString] = formatYAxisValueLabel(value: current, shouldCellIncrement: shouldCeilIncrement)
        }
        
        return ChartAxisData(
            axisStart: lowest + 0.01,
            axisEnd: highest + 0.01,
            strideBy: strideBy,
            map: map
        )
    }
    
    func formatYAxisValueLabel(value: Double, shouldCellIncrement: Bool) -> String {
        if shouldCellIncrement {
            return String(Int(ceil(value)))
        } else {
            return Utils.numberFormatter.string(from: NSNumber(value: value)) ?? value.roundedString
        }
    }
    
    //MARK: - previousCloseRuleMarkValue
    func previousCloseRuleMarkValue(data: ChartData, yAxisData: ChartAxisData) -> Double? {
        guard let previousClose = data.meta.previousClose, selectedRange == .oneDay else {
            return nil
        }
        return (yAxisData.axisStart <= previousClose && previousClose <= yAxisData.axisEnd) ? previousClose : nil
    }

}
