//
//  StockAppApp.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct StockAppApp: App {
    @State var viewModel = CoinViewModel()
    @StateObject var signUpViewModel = AuthorizationVIewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        //MARK: - 카카오 로그인  관련
//        KakaoSDK.initSDK(appKey: SecretKey.kakoNativeAppKey)
              //MARK: - 네비게이션 바 설정
        FirebaseApp.configure()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.colorAssets.black)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.colorAssets.black),
                                                            .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
        
        UINavigationBar.appearance().tintColor = UIColor(Color.colorAssets.black)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabVIew()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
            .environmentObject(signUpViewModel)
        }
    }
}
