//
//  AppDelegate.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/12.
//

import SwiftUI
import FirebaseCore
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        
        return true
    }
}

