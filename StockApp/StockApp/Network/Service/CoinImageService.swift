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
    private let fileManger = LocalFileManger.instaince
    private let folderName = "co'in_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    //MARK:  - 코인 이미지 가져오기
    private func getCoinImage() {
        if let savedImage = fileManger.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
//            debugPrint("Retrived image from File manger !")
        } else {
            downloadCoinImage()
//            debugPrint("downloadimage now")
        }
    }
    
    //MARK: - 코인 이미지 다운로드
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =   NetworkingManger.downloadUrl(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedImage) in
                guard let self = self,  let downloadImage = returnedImage  else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManger.savedImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
