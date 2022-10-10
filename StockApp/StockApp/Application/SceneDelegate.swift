//
//  SceneDelegate.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import Foundation
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
           if let url = URLContexts.first?.url {
               if (AuthApi.isKakaoTalkLoginUrl(url)) {
                   _ = AuthController.handleOpenUrl(url: url)
               }
           }
       }
}
