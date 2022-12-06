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
    @ObservedObject var viewModel: StockChartViewModel
    
    var body: some View {
        chart()
            .chartXScale(domain: data.itmes.first!.timestamp...data.itmes.last!.timestamp)
            .chartYScale(domain: data.yAxisData.axisStart...data.yAxisData.axisEnd)
            .chartPlotStyle { chartPlotStyle($0) }
            .chartOverlay {  proxy in
                GeometryReader {  gProxy in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged {
                                onChangeDrag(value: $0, chartProxy: proxy, geometryProxy: gProxy) }
                            .onEnded { _ in
                                viewModel.selectedX = nil
                            }
                        )
                }
            }
    }
    
    //MARK: - 차트 메인
    @ViewBuilder
    private func chart() -> some  View {
        Chart {
            ForEach(data.itmes) {
                LineMark(x: .value("Time", $0.timestamp),
                         y: .value("Price", $0.value))
                .foregroundStyle(viewModel.forgroundMarkColor)
                
                AreaMark(
                    x: .value("Time", $0.timestamp),
                    yStart: .value("Min", data.yAxisData.axisStart),
                    yEnd: .value("Max", $0.value)
                )
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [viewModel.forgroundMarkColor, .clear]), startPoint: .top, endPoint: .bottom))
                .opacity(0.3)
                
                if let previouseClose = data.previousCloseRuleMarkValue {
                    RuleMark(y: .value("Previous close", previouseClose))
                        .lineStyle(.init(lineWidth: 0.1, dash: [2]))
                        .foregroundStyle(.gray.opacity(0.3))
                }
                
                if let (selectedX, text) = viewModel.selectedXRuleMark {
                    RuleMark(x: .value("Selected timestamp", selectedX))
                        .lineStyle(.init(lineWidth: 1))
                        .annotation {
                            Text(text)
                                .spoqaHan(family: .Regular, size: 14)
                                .foregroundColor(Color.colorAssets.skyblue4.opacity(0.8))
                        }
                        .foregroundStyle(viewModel.forgroundMarkColor)
                }
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
    //MARK: - 드래그 해서 가격 확인
    
    private func onChangeDrag(value: DragGesture.Value, chartProxy: ChartProxy, geometryProxy: GeometryProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let xCurrent = value.location.x - geometryProxy[chartProxy.plotAreaFrame].origin.x
            
            if let timestamp: Date = chartProxy.value(atX: xCurrent),
               let startDate = data.itmes.first?.timestamp,
               let lastDate = data.itmes.last?.timestamp,
               timestamp >= startDate && timestamp <= lastDate {
                viewModel.selectedX = timestamp
            }
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
                StockChartView(data: charViewData, viewModel: chartVM)
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
