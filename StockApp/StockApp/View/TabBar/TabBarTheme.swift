//
//  TabBarTheme.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/29.
//

import SwiftUI

struct TabBarTheme {
    static func tabBarColor(forScheme scheme: ColorScheme) -> Color {
        let lightColor =  Color.colorAssets.navy2.opacity(0.8)
        let darckColor = Color.colorAssets.navy2.opacity(0.8)
        
        switch scheme {
        case .light:
            return lightColor
        case .dark:
            return darckColor
        @unknown default:
            return lightColor
        }
    }
}
