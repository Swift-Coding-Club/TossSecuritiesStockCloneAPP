//
//  SnsLoginManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
import KakaoSDKUser
import Foundation

enum SignType: String, Codable {
    case kakao = "kakao"
    case google = "google"
    case apple = "apple"
}

class SNSLoginManger: ObservableObject {
    //MARK: - sns callback
    var snsCallback: ((_ snsId: String, _ email: String, _ accessToken: String) -> Void)?
    
    init() {
//        MainTabVIew()
    }
}

extension SNSLoginManger {
    func kakoLogin() {
        // 카카오톡 설치 여부
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoAccount  { (oauthToken , error) in
                if let error = error {
                    debugPrint(" [🔥] 카카오톡 로그인 error \(error.localizedDescription)")
                } else  {
                    debugPrint("카카오톡 로그인 sucess ")
                    _ = oauthToken
                    
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    debugPrint(" [🔥] 카카오톡 로그인 error \(error.localizedDescription)")
                } else  {
                    debugPrint("카카오톡 로그인 sucess ")
                    _ = oauthToken
                    self.kakaoGetUser(oauthToken?.accessToken ?? "")
                }
            }
        }
    }
    
    private func kakaoGetUser(_ accessToken: String) {
        UserApi.shared.me { (user, error) in
            if let error = error {
                debugPrint(" [🔥] 카카오톡  유저 가져오기 실패 \(error.localizedDescription)")
            }
            else  {
                debugPrint("카카오톡 유저 가져오기  sucess ")
                _ = user
                
                let userid = "\(user?.id ?? .zero)"
                let email = user?.kakaoAccount?.email ?? ""
                if let callback = self.snsCallback {
                    callback(userid, email, accessToken)
                }
            }
        }
    }
}

