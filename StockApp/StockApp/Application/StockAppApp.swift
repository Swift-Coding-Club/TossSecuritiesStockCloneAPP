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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.colorAssets.subColor), .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.colorAssets.subColor),
            .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
    }
    
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
