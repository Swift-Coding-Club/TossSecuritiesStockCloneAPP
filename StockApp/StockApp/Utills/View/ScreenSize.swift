//
//  ScreenSize.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/23.
//

import SwiftUI
import UIKit

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UIApplication {
    static let safeAreaInsets = UIApplication.shared.windows[0].safeAreaInsets
    static let contentsHeight = UIScreen.screenHeight-UIApplication.safeAreaInsets.top-UIApplication.safeAreaInsets.bottom
    static let contentsWidth = UIScreen.screenWidth-UIApplication.safeAreaInsets.left-UIApplication.safeAreaInsets.right
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows[0].safeAreaInsets.bottom
        return bottom > 0
    }
}

extension View{
    
    func getRect()->CGRect{
        UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}
