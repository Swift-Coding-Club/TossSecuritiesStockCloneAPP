//
//  GradiantColorAsset.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/15.
//

import SwiftUI

struct GradiantColorAsset {
    let blue = Color("Blue")
    let darkBlue = Color("DarkBlue")
    let skyBlue = Color("SkyBlue")
    let white = Color("White")
}

extension Color {
    static let gradiantColr = GradiantColorAsset()
}
