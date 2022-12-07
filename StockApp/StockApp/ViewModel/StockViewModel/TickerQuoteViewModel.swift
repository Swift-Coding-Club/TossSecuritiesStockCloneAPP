//
//  StockChartViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import SwiftUI
import Combine
import XCAStocksAPI

@MainActor
class TickerQuoteViewModel: ObservableObject {
 
    
    @Published var stockChartData: [StockChartRow] = []
    @Published var phase = FetchPhase<Quote>.initial
    var nsdStockChartSubscription: AnyCancellable?
    var quote: Quote? { phase.value }
    var error: Error? { phase.error }
    
    let ticker: Ticker
    let stocksAPI : StockApIService
    
    init(ticker: Ticker, stocksAPI: StockApIService = XCAStocksAPI()) {
        self.ticker = ticker
        self.stocksAPI = stocksAPI
    }
    
    private func toViewModel(_ model : StockChartModel) {
        self.stockChartData = model.chart?.result ?? []
    }
    
    func fetchQuote() async {
        phase  = .fetching
        do {
            let response = try await stocksAPI.fetchQuotes(symbols: ticker.symbol)
            if let quote = response.first {
                phase = .success(quote)
            } else {
                phase = .empty
            }
        } catch {
            print(error.localizedDescription)
            phase = .failuer(error)
        }
    }
    
    func getStockNsdChartData() {
        if let cancellable = nsdStockChartSubscription {
            cancellable.cancel()
        }
        let parm = getStockFininaceChartListParm(range: ChartRangeParm.oneday.description, interval: ChartintervalParm.oneMin.description, includeTimestamp: true, indicators: ChartindicatorsParm.quote.description)
        nsdStockChartSubscription = StockAPI.getStockNsdFinianceChartData(parm)
            .compactMap {$0}
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                self?.toViewModel(model)
            })
    }
}
