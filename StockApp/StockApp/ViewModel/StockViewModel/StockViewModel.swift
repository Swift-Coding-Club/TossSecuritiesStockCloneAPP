//
//  StockViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import Foundation
import Combine

class StockViewModel: ObservableObject  {
    
    @Published var allStock :  [StockMostModelResponseQuote] = []             // 주식 관련
    @Published var isLoading: Bool = false                                      // 로딩 관련
    private let stockMostService = StockMostViewModel()
    
    private var cancelables = Set <AnyCancellable>()                  // 구독 취소하는 변수
    
    init() {
    }


}
