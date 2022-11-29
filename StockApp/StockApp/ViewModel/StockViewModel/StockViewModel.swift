//
//  StockViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import SwiftUI
import Combine
import XCAStocksAPI

class StockViewModel: ObservableObject  {

    var stockSubscription: AnyCancellable?
    var newyorkStockSubscription: AnyCancellable?
    
    @Published var stockOverViewData: [QuoteResponseRow] = []
    @Published var isLoading: Bool = false
    
    init() {
        reloadData()
    }
    
    private func toViewModel(_ model: StockModel) {
        self.stockOverViewData = model.quoteResponse?.result ?? []
    }
    
    //MARK: - 주식 데이터리스트
    func getStockData() {
        if let cancellable = stockSubscription {
            cancellable.cancel()
        }
        let parm = getStockYahooDataListParm(symbols: StockSymbol.nsdSymbol.description)
        stockSubscription = StockAPI.getStockYahooListData(parm)
            .compactMap {$0}
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                self?.isLoading = false
                self?.toViewModel(model)
            })
    }
    
    //MARK: - 뉴욕 주식 데이터 리스트
    func getNewYorkStockData() {
        if let cancellable = newyorkStockSubscription {
            cancellable.cancel()
        }
        let parm = getStockYahooDataListParm(symbols: StockSymbol.newyorkSymbol.description)
        newyorkStockSubscription = StockAPI.getStockYahooListData(parm)
            .compactMap {$0}
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                self?.isLoading = false
                self?.toViewModel(model)
            })
    }

    
    //MARK: - 주식 리로드
    func reloadData() {
        isLoading = true
        getStockData()
        getNewYorkStockData()
    }
}

