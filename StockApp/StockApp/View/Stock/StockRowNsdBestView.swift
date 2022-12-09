//
//  StockRowNsdBestView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/09.
//

import SwiftUI

struct StockRowBestView: View {
    
    @StateObject var stockViewModel: StockViewModel
    
    var symbol: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(Array(stockViewModel.stockOverViewData.enumerated()), id: \.offset ) { index , stock in
                    LazyVStack() {
                        StockRowView(stock: stock)
                            .padding(.horizontal, 10)
                            .onAppear {
                                let count = stockViewModel.stockOverViewData.count
                                if index == count - 5 {
                                    stockViewModel.getStockBest5Data(symbol: symbol)
                                }
                            }
                    }
                }
            }
        }
        .bounce(false)
        .padding(.init(top: 26, leading: .zero, bottom: 48, trailing: 10))
    }
}

struct StockRowBestView_Previews: PreviewProvider {
    static var previews: some View {
        StockRowBestView(stockViewModel: dev.stockViewModel, symbol: StockSymbol.nsdSymbolBest5.description)
    }
}
