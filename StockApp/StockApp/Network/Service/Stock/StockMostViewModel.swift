//
//  StockMostViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/19.
//

import SwiftUI
import Combine

class StockMostViewModel: ObservableObject {
    
    var stockSubscription: AnyCancellable?
    
    @Published var stockData: [StockMostModelResponseQuote] = []
    @Published var start: Int = .zero
    @Published var totalCount: Int = 0
    @Published var isLoading: Bool = false
    
    init() {
        getStockMostData()
    }
    
    private func toViewModel(_ model: StockMostModelResponse) {
        self.totalCount = model.total ?? .zero
        if start == 1  {
            self.stockData = model.quotes ?? []
        } else  {
            self.stockData += model.quotes ?? []
        }
    }
    
    //MARK: - 인기순 주식 데이터
    func getStockMostData() {
        if let cancellable = stockSubscription {
            cancellable.cancel()
        }

        let parm = getStockDataParm(start: start)
        stockSubscription = StockAPI.getStockData(parm)
            .compactMap { $0 }
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { model in
                self.toViewModel(model)
            })
    }
    
    func reloadData() {
        isLoading = true
        getStockMostData()
    }
    
}
