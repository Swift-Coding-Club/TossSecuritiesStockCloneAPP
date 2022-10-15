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

class SignUpVIewModel: ObservableObject {
    //MARK: - 유저
    @Published var userSession: FirebaseAuth.User?
    
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
    //MARK: - 로그아웃
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
