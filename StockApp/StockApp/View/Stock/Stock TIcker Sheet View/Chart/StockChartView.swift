//
//  StockChartView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/05.
//

import Charts
import SwiftUI
import XCAStocksAPI

@available(iOS 16.0, *)
struct StockChartView: View {
    
    let data: ChartViewData
    
    var body: some View {
        chart()
            .chartYScale(domain: data.itmes.map { $0.value }.min()!...data.itmes.map { $0.value}.max()!)
            .chartPlotStyle { chartPlotStyle($0) }
           
    }
    
    //MARK: - 차트 메인
    @ViewBuilder
    private func chart() -> some  View {
        Chart {
            ForEach(data.itmes) {
                LineMark(x: .value("Time", $0.timestamp),
                         y: .value("Price", $0.value))
                .foregroundStyle(data.lineColor)
                
                AreaMark(
                    x: .value("Time", $0.timestamp),
                    yStart: .value("Min", data.itmes.map {
                        $0.value }.min()!),
                    yEnd: .value("Max", $0.value)
                )
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [data.lineColor, .clear]), startPoint: .top, endPoint: .bottom))
                .opacity(0.3)
            }
        }
    }
    //MARK: - 차트 스타일
    @ViewBuilder
    private func chartPlotStyle(_ plotContent: ChartPlotContent) -> some View {
        plotContent
            .frame(height: 200)
            .overlay {
                //MARK: - 차트 x축 선
                Rectangle().foregroundColor(.gray.opacity(0.5))
                    .mask(ZStack {
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 1)
                        }
                        //MARK: - 차트 y축 선
                        HStack {
                            Spacer()
                            Rectangle()
                                .frame(width: 0.3)
                        }
                    })
            }
    }
}

@available(iOS 16.0, *)
struct StockChartView_Previews: PreviewProvider {
    
    static let allRanges = ChartRange.allCases
    static let oneDayOngoing = ChartData.stub1DOngoing
    
    
    static var previews: some View {
        ForEach(allRanges) {
            ChartContainerView_Previews(chartVM: chartViewModel(range: $0, stub: $0.stubs), title:  $0.title)
        }
        
        ChartContainerView_Previews(chartVM: chartViewModel(range: .oneDay, stub: oneDayOngoing), title: "1D ongoing")
    }
    
    static func chartViewModel(range: ChartRange, stub: ChartData) -> StockChartViewModel {
        var mockStockAPI = MockStockAPI()
        mockStockAPI.stubbedFetchChartDataCallback = { _ in stub }
        let chartVM = StockChartViewModel(ticker: .stub, stockAPI: mockStockAPI)
        return chartVM
    }
}

#if DEBUG
@available(iOS 16.0, *)
struct ChartContainerView_Previews: View {
    
    @StateObject var chartVM: StockChartViewModel
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            if let charViewData = chartVM.chart {
                StockChartView(data: charViewData)
            }
        }
        .padding()
        .frame(maxHeight: 272)
        .previewLayout(.sizeThatFits)
        .previewDisplayName(title)
        .task {
            await chartVM.fetchData()
        }
    }
}
#endif
