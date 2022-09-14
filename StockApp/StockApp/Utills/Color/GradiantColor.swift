//
//  GradiantColor.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/15.
//

import SwiftUI

struct GradiantColor {
    let skyblueGradiant = Gradient(colors: [Color.gradiantColr.white, Color.gradiantColr.skyBlue])
    let darkBlueGradiant = Gradient(colors: [Color.gradiantColr.blue, Color.gradiantColr.darkBlue])
}

extension Gradient {
    static let gradiant = GradiantColor()
}
