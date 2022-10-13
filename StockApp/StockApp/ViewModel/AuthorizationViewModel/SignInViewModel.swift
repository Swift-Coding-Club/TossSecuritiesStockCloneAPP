//
//  SignInViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
import Combine

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
        }
    }
}

