//
//  HapticManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/28.
//

import Foundation
import SwiftUI

//MARK:  - 스크롤 했을경우 진동
class HapticManger {
    static  let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:  UINotificationFeedbackGenerator.FeedbackType)  {
        generator.notificationOccurred(type)
    }
}
