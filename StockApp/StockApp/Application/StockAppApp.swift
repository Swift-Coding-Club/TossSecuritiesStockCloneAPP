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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.fontColor.mainFontColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.fontColor.mainFontColor),
                                                            .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabVIew()
//                HomeView()
//                    .environmentObject(signUpViewModel)
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
            .environmentObject(signUpViewModel)
        }
    }
}
