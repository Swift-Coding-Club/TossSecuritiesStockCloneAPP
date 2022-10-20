//
//  CustomFont.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/17.
//

import UIKit
import SwiftUI

enum SpoqaHanFamily: String {
    case Bold, Light, Medium, Regular, Thin
}

struct SpoqaHanFont: ViewModifier {
    var family: SpoqaHanFamily
    var size: CGFloat
    
    func body(content: Content) -> some View {
        return content.font(.custom("SpoqaHanSansNeo-\(family)", fixedSize: size))
    }
}

extension View {
    func spoqaHan(family: SpoqaHanFamily, size: CGFloat) -> some View {
        return self.modifier(SpoqaHanFont(family: family, size: size))
    }
}

extension UIFont {
    static func spoqaHan(family: SpoqaHanFamily, size: CGFloat) -> UIFont?{
        let font = UIFont(name: "SpoqaHanSansNeo-\(family)", size: size)
        return font
    }
}

extension Font {
    static func spoqaHan(family: SpoqaHanFamily, size: CGFloat) -> Font{
        let font = Font.custom("SpoqaHanSansNeo-\(family)", size: size)
        return font
    }
}

