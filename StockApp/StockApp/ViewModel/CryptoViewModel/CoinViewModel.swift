//
//  CoinViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/21.
//

import Foundation
// ObservableObject 로 뷰를 관찰및 접근
class CoinViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = [ ]
    @Published var profilioCoins : [CoinModel] =  [ ]
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DevloperPreview.instance.coin)
            self.profilioCoins.append(DevloperPreview.instance.coin)
        }
    }
}
