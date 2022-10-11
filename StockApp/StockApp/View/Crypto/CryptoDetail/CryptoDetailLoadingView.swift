//
//  DetailLoadingView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/30.
//

import SwiftUI

struct CryptoDetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                CryptoDetailView(coin: coin)
            }
        }
    }
}

struct CryptoDetailLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailLoadingView(coin: .constant(dev.coin))
    }
}
