//
//  ShareFont.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/23.
//

import UIKit
import SwiftUI

struct ShareHanFont: ViewModifier {
    var size: CGFloat
    var color: Color
    func body(content: Content) -> some View {
        return content.font(.custom("나눔손글씨 둥근인연", fixedSize: size))
            .foregroundColor(color)
    }
}

extension View {
    func ShareFont(size: CGFloat,
                   color: Color) -> some View {
        return self.modifier(StockApp.ShareHanFont(size: size, color: color))
    }
}

extension UIFont {
    static func ShareHanFont(size: CGFloat) -> UIFont?  {
        let font = UIFont(name: "나눔손글씨 둥근인연", size: size)
            return font
    }
}

extension Font {
    static func ShareHanFont(size: CGFloat, color: Color) -> Font {
        let font = Font
            .custom("나눔손글씨 둥근인연", size: size)
            return font
    }
}
