//
//  CryptoStatView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/25.
//

import SwiftUI

struct CryptoStatView: View {
    
    @Binding var showPortfolio: Bool
    @EnvironmentObject private var viewModel: CoinViewModel
    
    var body: some View {
        HStack {
            ForEach(viewModel.statistic) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct CryptoStatView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoStatView(showPortfolio: .constant(false))
            .environmentObject(dev.coinViewModel)
    }
}
