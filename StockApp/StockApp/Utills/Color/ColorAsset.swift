//
//  ColorAsset.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI

struct ColorAsset {
    let mainColor = Color("MainColor")
    let subColor = Color("MainColor2")
    let black = Color("Black")
    let blue = Color("Blue")
    let blue2 = Color("Blue2")
    let blue3 = Color("Blue3")
    let  lightgreen  = Color("LightGreen")
    let lightRed = Color("LightRed")
    let mauvepurple = Color("Mauve")
    let navy = Color("Navy")
    let navy2 = Color("Navy2")
    let skyblue = Color("Skyblue")
    let white = Color("White")
}

extension Color {
    static let colorAssets = ColorAsset()
}
