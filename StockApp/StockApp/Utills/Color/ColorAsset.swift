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
    let blue4 = Color("Blue4")
    let lightBlue = Color("LightBlue")
    let lightgreen  = Color("LightGreen")
    let lightgreen2  = Color("LightGreen2")
    let lightRed = Color("LightRed")
    let mauvepurple = Color("Mauve")
    let mauvepurple2 = Color("Mauve2")
    let mauvepurple3 = Color("Mauve3")
    let navy = Color("Navy")
    let navy2 = Color("Navy2")
    let navy3 = Color("Navy3")
    let pink = Color("Pink")
    let skyblue = Color("Skyblue")
    let skyblue2 = Color("Skyblue2")
    let white = Color("White")
    let white2 = Color("White2")
}

extension Color {
    static let colorAssets = ColorAsset()
}
