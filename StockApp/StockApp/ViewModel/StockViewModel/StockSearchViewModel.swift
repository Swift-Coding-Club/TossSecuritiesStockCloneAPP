//
//  StockSearchViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/29.
//

import Foundation
import Combine
import SwiftUI
import XCAStocksAPI

class StockSearchViewModel : ObservableObject {
    
    @Published var searchStock: String = ""
    var stockSearchSubscription: AnyCancellable?
    
    @Published var stockSearchData : [SearchQuote] = []
    @Published var totalCount: Int = .zero
    @Published var phase : FetchPhase<[Ticker]> = .initial
    
    private var trimmedQuery: String {
        searchStock.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var tickers: [Ticker] { phase.value ?? [] }
    var error: Error? { phase.error}
    var isSearching: Bool { !trimmedQuery.isEmpty }
    
    var emptyListText: String {
        "검색 결과에 대한 주식을 찾을수 없습니다\n\(searchStock)"
    }
    
    init() {
        
    }
    
    private func searchToViewModel(_ model: StockSearchModel) {
        self.totalCount = model.count ?? .zero
        self.stockSearchData = model.quotes ?? []
    }
    

    func getStockSearchData() {
        if let cancellable = stockSearchSubscription {
            cancellable.cancel()
        }
        let parm = getStockSearchYahooDataListParm(q: searchStock)
        stockSearchSubscription = StockAPI.getStockSearchYahooListData(parm)
            .compactMap {$0}
            .sink(receiveCompletion: { error in
                print("검색 에러 \(error)")
            }, receiveValue: { [weak self] model in
                self?.searchToViewModel(model)
            })
    }
}
