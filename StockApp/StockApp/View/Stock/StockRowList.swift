//
//  StockRowList.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/27.
//

import SwiftUI

struct StockRowList: View {
    @StateObject var stockViewModel: StockViewModel
    
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
                                    stockViewModel.getStockData()
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

struct StockRowList_Previews: PreviewProvider {
    static var previews: some View {
        StockRowList(stockViewModel: dev.stockViewModel)
    }
}
