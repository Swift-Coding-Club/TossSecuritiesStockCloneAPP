//
//  StockViewModels.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import Foundation
import SwiftUI
import Combine
import XCAStocksAPI

@available(iOS 16.0, *)
@MainActor
class StockViewModels: ObservableObject {
    
    @Published var tickers: [Ticker] = [] {
        didSet { savedTickers() }
    }
    
    @Published var selectedTicker: Ticker?
    @Published var subTitleText: String
    
    var titleText = "주식"
    var emptyTickersText = "검색후 & 주식을 추가 하여 주식 시세를 보세요!"
    var attributionText = "Powered by Yahoo! finance API"
    
    private let subTitleDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월dd일"
        return dateFormatter
    }()
    
    let tickerListRepository: TickerListRepository
    
    init(repository: TickerListRepository = TickerPlistRepository()) {
        self.tickerListRepository = repository
        self.subTitleText = subTitleDateFormatter.string(from: Date())
        loadTickers()
    }
    
    //MARK: 주식 load
    private func loadTickers() {
        Task { [weak self] in
            guard let self  = self else { return }
            do {
                self.tickers = try await tickerListRepository.load()
            } catch {
                print(error.localizedDescription)
                self.tickers = []
            }
        }
    }
    
    
    private func savedTickers() {
        Task { [weak self] in
            guard let self  = self else { return }
            do {
                try await self.tickerListRepository.save(self.tickers)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - 주식 삭제
    func removeTickers(atOffsets offsets: IndexSet) {
        tickers.remove(atOffsets: offsets)
    }
    
    //MARK: - 검색후 주식 추가

    func isAddedToMyTickers(ticker: Ticker) -> Bool {
        tickers.first { $0.symbol == ticker.symbol } != nil
    }
    
    func toggleTicker(_ ticker: Ticker) {
        if isAddedToMyTickers(ticker: ticker) {
            removeFromMyTickers(ticker: ticker)
        } else  {
            addToMyTickers(ticker: ticker)
        }
    }
    
    private func addToMyTickers(ticker: Ticker) {
        tickers.append(ticker)
    }
    
    //MARK: - 주식 리스트 삭제
  private func removeFromMyTickers(ticker: Ticker) {
        guard let index = tickers.firstIndex(where: { $0.symbol == ticker.symbol}) else { return }
        tickers.remove(at: index)
    }
    
    func openYahooFinance() {
        let url = URL(string: "https://finance.yahoo.com")!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
