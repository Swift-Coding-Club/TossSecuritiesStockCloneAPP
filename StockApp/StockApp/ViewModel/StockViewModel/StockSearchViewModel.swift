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

@MainActor
class StockSearchViewModel : ObservableObject {
    
    @Published var searchStock: String = ""
    var stockSearchSubscription: AnyCancellable?
    var stockSearchsubscription = Set<AnyCancellable>()
    
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
    
    private let stockAPI: StockApIService
    
    init(searchStock: String = "" , stockAPI: StockApIService = XCAStocksAPI()) {
        self.searchStock = searchStock
        self.stockAPI = stockAPI
        
        stockSearch()
    }
    
    //MARK: - 데이터 통신 부분
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
    
    private func stockSearch() {
        $searchStock
            .debounce(for: 0.25, scheduler: DispatchQueue.main)
            .sink { _ in
                Task {[weak self] in await self?.searchTicker() }
            }
            .store(in: &stockSearchsubscription)
        
        $searchStock
            .filter { $0.isEmpty }
            .sink { [weak self] _ in self?.phase = .initial }
            .store(in: &stockSearchsubscription)
    }
    
    
    func searchTicker() async {
        let searchQuery = trimmedQuery
        guard !searchQuery.isEmpty else { return }
        phase  = .fetching
        
        do {
            let tickers =  try  await stockAPI.searchTickers(query: searchQuery, isEquityTypeOnly: true)
            if searchQuery != trimmedQuery { return }
            if tickers.isEmpty {
                phase = .empty
            } else {
                phase = .success(tickers)
            }
        } catch {
            if searchQuery != trimmedQuery { return }
            print("검색 에러 \(error.localizedDescription)")
            phase = .failuer(error)
        }
    }
}
