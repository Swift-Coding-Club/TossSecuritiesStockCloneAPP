//
//  SignUpVIewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
import KakaoSDKAuth
import AuthenticationServices
import GoogleSignIn

class AuthorizationVIewModel:  ObservableObject {
    
    //MARK: - 유저
    @Published var userSession: FirebaseAuth.User?
    @StateObject var snsloginManager: SNSLoginManger = SNSLoginManger()
    @Published var nonce = ""
    @AppStorage("log_status") var log_Status = false
        
    init() {
        self.userSession = Auth.auth().currentUser
        debugPrint("DEBUG: User session is \(self.userSession)")
        
    }
    
    //MARK: - 로그인
    func login(withEmail email: String, password: String) {
        //        debugPrint("DEBUG: User login with email \(email)")
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                debugPrint("[🔥] 로그인 에 실패 하였습니다 \(error.localizedDescription)")
                return
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                
                debugPrint("로그인에 성공 하였습니다")
            }
        }
    }
    
    //MARK: - 회원 가입
    func register(withEmail email: String, password: String, fullname: String, phoneNumber: String, userName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                debugPrint("[🔥] 회원가입에 실패 하였습니다 \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            debugPrint("회원가입에 성공 하였습니다 ")
            debugPrint("debug user is \(self.userSession)")
            
            let data = ["email" : email ,
                        "username" : userName.lowercased(),
                        "fullname" : fullname,
                        "phonenumber" : phoneNumber,
                        "uid" : user.uid]
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { data in
                    debugPrint("DEBUG : Upload user data : \(data)")
                }
        }
    }
    
    //MARK: -  애플 로그인
    func appleLogin(credential : ASAuthorizationAppleIDCredential ) {
        //MARK:  - 토큰 가져오기
        guard let token = credential.identityToken else {
            debugPrint("[🔥] 파이어 베이스 로그인 에 실패 하였습니다 ")
            return
        }
        //MARK: - 토큰을 문자열 변환
        guard let tokenString = String(data: token, encoding: .utf8) else {
            debugPrint("[🔥]  error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                          idToken: tokenString,
                                                          rawNonce: nonce)
        
        //MARK: - 파이어 베이스 로그인
        
        Auth.auth().signIn(with: firebaseCredential) { (result , error) in
            if let error = error {
                debugPrint("[🔥] 로그인 에 실패 하였습니다 \(error.localizedDescription)")
                return
            }   else {
                guard let user = result?.user else  {return}
                self.userSession = user
                debugPrint("[🔥]  로그인에  성공 하였습니다  \(user)")
                withAnimation(.easeInOut) {
                    self.log_Status = true
                }
            }
        }
    }
    //MARK: - 구글 로그인
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID  else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting:  UIApplication.shared.getRootViewController()) {[self] user, error in
            if let error = error {
                debugPrint("[🔥] 로그인 에 실패 하였습니다 \(error.localizedDescription)")
                return
            }
            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
                
                debugPrint("[🔥]  로그인에  성공 하였습니다  \(user?.profile?.email)")
//                self.userSession = user
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    debugPrint("[🔥] 로그인 에 실패 하였습니다 \(error.localizedDescription)")
                    return
                } else {
                    debugPrint("[🔥]  로그인에  성공 하였습니다  \(user)")
                    guard let user = authResult?.user else {return}
                    self.userSession = user
                }
            }
            
        }
        
    }
    
    //MARK: - 로그아웃
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
