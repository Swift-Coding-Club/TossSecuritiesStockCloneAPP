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
    @State private var showLanchView: Bool = true
    
    init() {
        //MARK: - 카카오 로그인  관련
//        KakaoSDK.initSDK(appKey: SecretKey.kakoNativeAppKey)
              //MARK: - 네비게이션 바 설정
        FirebaseApp.configure()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.fontColor.mainFontColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.fontColor.mainFontColor),
                                                            .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
        
        UINavigationBar.appearance().tintColor = UIColor(Color.fontColor.mainFontColor)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    MainTabVIew()
                        .navigationBarHidden(true)
                }
                .environmentObject(viewModel)
                .environmentObject(signUpViewModel)
                
                ZStack {
                    if showLanchView {
                        LanchView(showLanchView: $showLanchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
