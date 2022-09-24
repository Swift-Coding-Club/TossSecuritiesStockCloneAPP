//
//  CoinImageView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/24.
//

import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLodaingImage{
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.colorAssets.textColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
