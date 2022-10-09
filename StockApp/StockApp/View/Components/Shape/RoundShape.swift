//
//  RoundShape.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
//MARK:  - corner를 둥글게 만들게 구현
struct RoundShape: Shape {
    
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        return Path(path.cgPath)
    }
}
