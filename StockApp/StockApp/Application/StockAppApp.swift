//
//  StockAppApp.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct StockAppApp: App {
    @State var viewModel = CoinViewModel()
    @StateObject var signUpViewModel = SignUpVIewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        //MARK: - 카카오 로그인  관련
        KakaoSDK.initSDK(appKey: SecretKey.kakoNativeAppKey)
      
        //MARK: - 네비게이션 바 설정
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.colorAssets.subColor), .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.colorAssets.subColor),
                                                            .font : UIFont(name: FontAsset.regularFont, size: 28) ?? ""]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabVIew()
//                    .environmentObject(signUpViewModel)
                    .onOpenURL(perform: { url in
                        if(AuthApi.isKakaoTalkLoginUrl(url)) {
                            AuthController.handleOpenUrl(url: url)
                        }
                    })
                    .navigationBarHidden(true)
            }
            .environmentObject(signUpViewModel)
            .environmentObject(viewModel)
        }
    }
}
