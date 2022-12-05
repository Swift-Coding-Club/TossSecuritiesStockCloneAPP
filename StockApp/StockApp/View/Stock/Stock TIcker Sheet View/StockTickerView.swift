//
//  StockTickerView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import SwiftUI
import XCAStocksAPI

struct StockTickerView: View {
    
    @StateObject var tickerQuoteViewModel: TickerQuoteViewModel
    @State var selectedRange = ChartRange.oneDay
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading,  spacing: .zero) {
            //MARK: - 헤더
            headerView()
                .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
                .padding(.horizontal)
            
            //MARK: - 헤더 밑  스크롤 뷰
            scrollView()
            
        }
        .padding(.top)
        .background(Color.colorAssets.backGroundColor)
        .onAppear {
            Task {
                await tickerQuoteViewModel.fetchQuote()
            }
        }
    }
    //MARK: - 헤더부분
    @ViewBuilder
    private func headerView() -> some View {
        HStack(alignment: .lastTextBaseline) {
            Text(tickerQuoteViewModel.ticker.symbol)
                .spoqaHan(family: .Bold, size: 25)
            
            if let shortName = tickerQuoteViewModel.ticker.shortname {
                Text(shortName)
                    .spoqaHan(family: .Bold, size:18)
                    .foregroundColor(Color.colorAssets.textColor)
            }
            
            Spacer()
            
            closedButton()
        }
    }
    //MARK: - 바텀 쉬트 닫기 버튼
    @ViewBuilder
    private func closedButton() -> some View {
        Button {
            dismiss()
        } label: {
            Circle().frame(width: 36, height: 36)
                .foregroundColor(Color.colorAssets.textColor.opacity(0.1))
                .overlay {
                    Image(systemName: "xmark")
                        .spoqaHan(family: .Bold, size: 17)
                        .foregroundColor(Color.colorAssets.textColor)
                    
                }
        }
        .buttonStyle(.plain)
        
    }
    //MARK: - 헤더 밑  스크롤 뷰
    @ViewBuilder
    private func scrollView() -> some View {
        ScrollView(showsIndicators: false) {
            priceDiffRowView()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top , 8)
                .padding(.horizontal)
            
            Divider()
            //MARK: - 날짜 선택
            DateRangePickerView(selectedRange: $selectedRange)
            
            Divider()
            
            Text("차트 뷰 ")
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 220)
            
            Divider()
                .padding([.horizontal, .top])
            
            quoteDetailView()
                .frame(maxWidth: .infinity, minHeight: 80)
        
        }
        .bounce(false)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    //MARK: - 주식 가격
    @ViewBuilder
    private func priceDiffRowView() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            if let quote  = tickerQuoteViewModel.quote {
                HStack {
                    if quote.isTrading,
                       let price = quote.regularPriceText,
                       let diff = quote.regularDiffText {
                        priceDiffStackView(price: price, diff: diff, caption: nil)
                    } else {
                        if let atClosedText = quote.regularPriceText,
                           let atClosedDiffText = quote.regularDiffText {
                            priceDiffStackView(price: atClosedText, diff: atClosedDiffText, caption: "종가")
                        }
                    }
                    
                    Spacer()
                        .frame(width: 15)
                    if let afterHourText = quote.postPriceText,
                       let afterHourDiffText = quote.postPriceDiffText {
                        priceDiffStackView(price: afterHourText, diff: afterHourDiffText, caption: "장외 시간")
                    }
                }
                Spacer()
            }
        }
        exchangeCurrencyView()
    }
    //MARK: - 주식 가격 텍스트
    @ViewBuilder
    private func priceDiffStackView(price: String, diff: String, caption: String?) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline, spacing: 16) {
                Text(price)
                
                Text(diff)
                    .foregroundColor(diff.hasPrefix("-") ?
                                     Color.colorAssets.lightRed :
                                        Color.colorAssets.skyblue4.opacity(0.8))
            }
            Spacer()
            if let caption {
                Text(caption)
                    .foregroundColor(Color.colorAssets.textColor)
            }
        }
        .spoqaHan(family: .Bold, size: 15)
    }
    //MARK: - 주식 currency
    @ViewBuilder
    private func exchangeCurrencyView() -> some View {
        HStack(spacing: 4) {
            if let exchange = tickerQuoteViewModel.ticker.exchDisp {
                Text(exchange)
            }
            if let currency = tickerQuoteViewModel.quote?.currency {
                Text("·")
                Text(currency)
            }
        }
        .spoqaHan(family: .Bold, size: 14)
        .foregroundColor(Color.colorAssets.textColor)
    }
    //MARK: - 주식 디테일 뷰
    @ViewBuilder
    private func quoteDetailView() -> some View {
        switch tickerQuoteViewModel.phase {
        case .fetching:
            LoadingStateView()
        case .failuer(let error):
            ErrorStateView(error: "주식 에러 \(error.localizedDescription)")
                .padding(.horizontal)
        case .success(let quote):
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(quote.columnItems) { items in
                        QuoteDetailColumnView(item: items)
                    }
                }
                .padding(.horizontal)
                .spoqaHan(family: .Bold, size: 15)
                .lineLimit(1)
            }
            .bounce(false)
        default:
            EmptyView()
        }
    }
}

struct StockTickerView_Previews: PreviewProvider {
    
    static var tradingStubsQuoteViewModel: TickerQuoteViewModel = {
        var mock  = MockStockAPI()
        mock.stubbedFetchQuoteCallBack = {
            [Quote.stub(isTrading: true)]
        }
        return TickerQuoteViewModel(ticker: .stub, stocksAPI: mock)
    }()
    
    static var closedStubsQuoteViewModel: TickerQuoteViewModel = {
        var mock  = MockStockAPI()
        mock.stubbedFetchQuoteCallBack = {
            [Quote.stub(isTrading: false)]
        }
        return TickerQuoteViewModel(ticker: .stub, stocksAPI: mock)
    }()
    
    static var loadingStubsQuoteViewModel: TickerQuoteViewModel = {
        var mock  = MockStockAPI()
        mock.stubbedFetchQuoteCallBack = {
            await withCheckedContinuation { _ in
                
            }
        }
        return TickerQuoteViewModel(ticker: .stub, stocksAPI: mock)
    }()
    
    static var errorStubsQuoteViewModel: TickerQuoteViewModel = {
        var mock  = MockStockAPI()
        mock.stubbedFetchQuoteCallBack = {
            throw NSError(domain: "error", code: .zero, userInfo: [NSLocalizedDescriptionKey: "에러 발생"])
        }
        return TickerQuoteViewModel(ticker: .stub, stocksAPI: mock)
    }()
    
    static var previews: some View {
        Group{
            StockTickerView(tickerQuoteViewModel: tradingStubsQuoteViewModel)
                .previewDisplayName("Trading")
                .frame(height: 700)
            
            StockTickerView(tickerQuoteViewModel: closedStubsQuoteViewModel)
                .previewDisplayName("Closeing")
                .frame(height: 700)
            
            StockTickerView(tickerQuoteViewModel: loadingStubsQuoteViewModel)
                .previewDisplayName("loading Quote")
                .frame(height: 700)
            
            StockTickerView(tickerQuoteViewModel: errorStubsQuoteViewModel)
                .previewDisplayName("Error Quote")
                .frame(height: 700)
        }
        .previewLayout(.sizeThatFits)
        
    }
}
