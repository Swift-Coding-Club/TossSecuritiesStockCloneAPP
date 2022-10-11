//
//  CryptoChartView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/03.
//

import SwiftUI

struct CryptoChartView: View {
    
    private let data: [Double]              // 차트 데이터
    private let maxY: Double                // y 값 최대
    private let minY: Double                // y 값 최소
    private let lineColor : Color        // 차트 컬러
    private let startingDate: Date      // 시작 날짜
    private let endingDate: Date        // 끝나는 날짜
    @State private var percentage: CGFloat = .zero
    @GestureState var isDrag: Bool = false
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? [ ]
        maxY = data.max() ?? .zero           // y 값 최대
        minY = data.min() ?? .zero         //  y 값 최소
        
        let priceChange = (data.last ?? .zero) - (data.first ?? .zero)
        lineColor = priceChange > .zero ? Color.colorAssets.green : Color.colorAssets.lightRed
        
        endingDate = Date(coinGeokoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            //MARK:  - 차트 뷰
            chartView()
                .frame(height: 300)
                .background(chartBackground())
                .overlay( chartYAxis().padding(.horizontal, 4) ,alignment: .leading )
            chartDateLabel()
                .padding(.horizontal, 4)
        }
        .font(.custom(FontAsset.mediumFont, size: 15))
        .foregroundColor(Color.colorAssets.textColor)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
    
    //MARK: - 차트 뷰
    @ViewBuilder
    private func chartView() -> some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    //MARK: - x 포지션
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    //MARK:  - y 포지션일때 1을 빼야되

                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == .zero {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
            }
            .trim(from: .zero, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
    }
    //MARK: - 차트 뷰 뒷 배경 divider()
    @ViewBuilder
    private func chartBackground() -> some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    //MARK: - 차트 y axis
    @ViewBuilder
    private func chartYAxis() -> some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    //MARK: - 코인 시세 날짜
    @ViewBuilder
    private func chartDateLabel() -> some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}

struct CryptoChartView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoChartView(coin: dev.coin)
    }
}
