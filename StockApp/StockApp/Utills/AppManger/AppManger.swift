//
//  AppManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/10.
//

import Foundation
import UIKit

class AppManager {
    static let shared = AppManager()
    
    
    var currentAppVersion: String? {
        guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String else {
            return nil
        }
        
        return version
    }
}
