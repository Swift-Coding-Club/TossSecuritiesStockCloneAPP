//
//  FontColorAsset.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/15.
//

import SwiftUI

struct FontColorAsset {
    let mainFontColor = Color("FontColor")
    let accentColor = Color("AccentColor")
}

extension Color {
    static let fontColor = FontColorAsset()
}
