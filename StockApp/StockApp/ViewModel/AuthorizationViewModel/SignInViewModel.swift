//
//  SignInViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class SignInViewModel: ObservableObject {
    
    private var loginCancellable: AnyCancellable?
    @Published var isLoginSuccess: Bool = false
    
    //MARK: - sns 로그인
    func signIn(_ userid: String, email: String, provider: SignType, saveLogInInfo: Bool) {
        signInSns(userid, email: email, provider: provider, saveLogInInfo: saveLogInInfo, isLoginAfterSignUp: false)
    }
    
    //MARK:  - sns 설정
    func signInSns(_ userId: String, email: String, provider: SignType, saveLogInInfo: Bool, isLoginAfterSignUp: Bool) {
        if let cancellables = loginCancellable {
            cancellables.cancel()
        } else  {
            self.isLoginSuccess = true
//            if (UserApi.isKakaoTalkLoginAvailable()) {
//                UserApi.shared.loginWithKakaoAccount { authtoken, error in
//                    self.loginCancellable = 
//                }
//            }
        }
    }
}

