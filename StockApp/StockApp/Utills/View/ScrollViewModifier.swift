//
//  ScrollViewModifier.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import SwiftUI

struct ScrollViewModifier: ViewModifier {
    init( isBounce: Bool) {
        UIScrollView.appearance().bounces = isBounce
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension ScrollView {
 
    func bounce(_ isBounce: Bool) -> some View {
        self.modifier(ScrollViewModifier(isBounce: isBounce))
    }
}

