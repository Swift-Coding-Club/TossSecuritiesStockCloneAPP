//
//  CoinImageViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/24.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var isLodaingImage: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
    }
    
    //MARK:  - 코인이미지 다운로드 받은걸 viewmodel로 사용 

    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLodaingImage = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancelables)

    }
}
