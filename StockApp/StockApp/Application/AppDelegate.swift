//
//  AppDelegate.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/12.
//

import SwiftUI
import FirebaseCore
import UIKit
import GoogleSignIn

class AppDelegate: UIViewController, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

