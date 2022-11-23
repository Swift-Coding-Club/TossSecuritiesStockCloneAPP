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
    var stockSmallCapSubscription: AnyCancellable?
    var stockIncreaseCapSubscription: AnyCancellable?
    var stockLargeCapSubscription: AnyCancellable?
    
    @Published var stockData: [StockMostModelResponse] = []
    @Published var start: Int = .zero
    @Published var totalCount: Int = 0
    @Published var isLoading: Bool = false
    
    init() {
        reloadData()
    }
    
    private func toViewModel(_ model: StockModel) {
        self.totalCount = model.data.total ?? .zero
        if start == 1  {
            self.stockData = model.data.quotes ?? []
        } else  {
            self.stockData += model.data.quotes ?? []
        }
    }
    
    //MARK: - 인기순 주식 데이터
    func getStockMostData() {
        if let cancellable = stockSubscription {
            cancellable.cancel()
        }

        let parm = getStockDataParm(start: start, list: StocklistParm.most_actives.description)
        stockSubscription = StockAPI.getStockData(parm)
            .compactMap { $0 }
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { model in
                self.isLoading  = false
                self.toViewModel(model)
                
            })
    }
    
//    //MARK: - 주식 변화량이 적은순
    func getStockSmallCapData() {
        if let cancellable = stockSmallCapSubscription {
            cancellable.cancel()
        }
        let parm = getStockSmallCapDataParm(start: start, list: StocklistParm.small_cap_gainers.description)
        stockSmallCapSubscription = StockAPI.getStockSmallCapData(parm)
            .compactMap { $0 }
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { model in
                self.isLoading  = false
                self.toViewModel(model)
            })
    }
    //MARK:  - 주식 상승률 있는
    func getStockIncreaseCapData() {
        if let cancellable = stockIncreaseCapSubscription {
            cancellable.cancel()
        }
        let parm = getStockIncreaseCapDataParm(start: start, list: StocklistParm.aggressive_small_caps.description)
        stockIncreaseCapSubscription = StockAPI.getStockIncreaseCapData(parm)
            .compactMap { $0 }
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { model in
                self.isLoading  = false
                self.toViewModel(model)
            })
    }
    //MARK: - 주식 변화율이 큰
    func getStockLargeCapData() {
        if let cancellable = stockLargeCapSubscription {
            cancellable.cancel()
        }
        let parm = getStockLargeCapDataParm(start: start, list: StocklistParm.undervalued_large_caps.description)
        stockLargeCapSubscription = StockAPI.getStockLargeCapData(parm)
            .compactMap { $0 }
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { model in
                self.isLoading  = false
                self.toViewModel(model)
            })
    }
    
    
    
    func reloadData() {
        isLoading = true
        getStockMostData()
        getStockSmallCapData()
        getStockIncreaseCapData()
        getStockLargeCapData()
    }
}
