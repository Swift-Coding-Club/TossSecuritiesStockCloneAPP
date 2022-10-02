//
//  CryptoCoinCardView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/02.
//

import SwiftUI

struct CryptoCoinCardView: View {
//    @Binding var showPortfolio: Bool
    @EnvironmentObject private var viewModel: CoinViewModel
     
    var body: some View {
        HStack {
            ForEach(viewModel.portfolioStatistic) { stat in
                CardViews(stat: stat)
            }
        }
    }
}

struct CryptoCoinCardView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCoinCardView()
            .environmentObject(dev.coinViewModel)
    }
}
