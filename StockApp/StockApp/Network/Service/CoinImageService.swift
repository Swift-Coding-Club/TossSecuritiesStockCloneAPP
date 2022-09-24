//
//  CoinImageService.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/24.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription : AnyCancellable?
    private let coin: CoinModel
    
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    //MARK: - 코인 이미지 다운로드 

    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =   NetworkingManger.downloadUrl(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
