//
//  TabViewManager.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/27.
//

import SwiftUI

class TabViewManager: ObservableObject {
    @Published var currentTab = 0

    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
    }
}


