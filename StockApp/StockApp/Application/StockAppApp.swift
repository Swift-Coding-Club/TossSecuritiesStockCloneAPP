//
//  StockAppApp.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI

@main
struct StockAppApp: App {
    @State var viewModel = CoinViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabVIew()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
