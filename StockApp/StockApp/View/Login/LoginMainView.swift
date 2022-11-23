//
//  LoginMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/05.
//

import SwiftUI
import AuthenticationServices
import Firebase

struct LoginMainView: View {
    
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @State private var showLoginView: Bool = false
    
    var body: some View {
        ZStack {
            Color.colorAssets.loginColor
                .ignoresSafeArea()
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Image("login_logo")
                        .resizable()
                        .frame(width: UIScreen.screenWidth, height: 350)
                        .ignoresSafeArea()
                    
                    loginTitle()
                    
                    Spacer()
                        .frame(height: 50)
                    
                    appleLoginButton()
                    
                    Spacer()
                        .frame(height: 15)
                    
                    googleLoginButton()
                    
                    Spacer()
                        .frame(height: 15)
                    
                    loginButton()

                    Spacer()
                        .frame(height: 15)
                }
                
                Spacer(minLength: .zero)
            }
        }
    }
    //MARK: - 로그인  타이틀
    @ViewBuilder
    private  func loginTitle() -> some View {
        VStack{
            HStack {
                Text("Welcome")
                    .spoqaHan(family: .Bold, size: 30)
                    .foregroundColor(Color.colorAssets.white2)
                Spacer()
            }
            .padding(.horizontal , 30)
            
            Spacer()
                .frame(height: 15)
            
            HStack {
                Text("코인 모야 서비스에 오신걸  환영합니다")
                    .spoqaHan(family: .Bold, size: 20)
                    .foregroundColor(Color.colorAssets.white2)
                
                Spacer()
            }
            .padding(.horizontal , 30)
        }
    }
    //MARK: - 애플 로그인 버튼
    @ViewBuilder
    private func appleLoginButton() -> some View {
        SignInWithAppleButton(.signIn) { request in
            viewModel.nonce =   UIApplication.shared.randomNonceString()
            request.requestedScopes = [.fullName, .email]
            request.nonce =  UIApplication.shared.sha256(viewModel.nonce)
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                
                print("로그인 성공 \(authResults)")
                
                guard let credential =  authResults.credential as?
                        ASAuthorizationAppleIDCredential  else  {
                    debugPrint("파이어 베이스 로그인 에러 ")
                    return
                }
                
                viewModel.appleLogin(credential: credential)
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 50)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.colorAssets.black, lineWidth: 1)
        )
        .padding(.horizontal, 30)
    }
    //MARK:  - 구글 로그인 버튼
    @ViewBuilder
    private func googleLoginButton() -> some View {
        Button{
            viewModel.googleLogin()
        } label: {
            HStack(spacing: 10) {
                
                Spacer()
                     
                Image("google_logo")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.colorAssets.black)
                
                Text("구글 계정으로 로그인")
                    .spoqaHan(family: .Bold, size: 20)
                    .foregroundColor(Color.colorAssets.black)
                
            Spacer()
            }
        }
       
        .frame(height: 50)
        .background(Color.colorAssets.white2)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.colorAssets.white, lineWidth: 1)
        
        )
        .padding(.horizontal, 30)

    }
    //MARK:  - 로그인 버튼
    @ViewBuilder
    private func loginButton() -> some View {
        Button {
            showLoginView.toggle()
        }label: {
            Text("로그인 하러 가기")
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(.white)
                .frame(width: 320, height: 50)
                .background(Color.colorAssets.skyblue4)
            
                .cornerRadius(10)
                
        }
        .background(
        NavigationLink(
                        destination: LoginView(),
                       isActive: $showLoginView,
                       label: {EmptyView()})
        )
    }
}

struct LoginMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginMainView()
                .environmentObject(dev.signUpViewModel)
        }
    }
}
