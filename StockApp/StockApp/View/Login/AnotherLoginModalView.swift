//
//  AnotherLoginModalView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
import AuthenticationServices
import Firebase

struct AnotherLoginModalView: View {
    @Environment (\.dismiss) private var dismiss
    
    @StateObject var snsloginManager: SNSLoginManger = SNSLoginManger()
    @State private var mainTabview: Bool = false
    @State private var showErrorMessage: Bool = false
    
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    
    public var delegate: SnsLoginDelegate?
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            VStack {
                //MARK: - 창을  닫는 버튼
                closeViewButton()
                
//                kakoLoginButton()
                appleLoginButton()
                
                Spacer()
                    .frame(height: 20)
                
                googleLoginButton()
                
                Spacer(minLength: .zero)
                
            }
        }
        .ignoresSafeArea()
    }
    
    //MARK: - 창 닫는 뷰
    @ViewBuilder
    private func closeViewButton() -> some View {
        HStack {
            Button {
                dismiss()
            }label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(Color.fontColor.mainFontColor)
                    .padding(20)
            }
            Spacer()
        }
    }
    //MARK: - 카카오 로그인 버튼
    @ViewBuilder
    private func kakoLoginButton() -> some View {
        Button {
            if let delegate = delegate {
                delegate.snsLoginSuccess()
                snsloginManager.kakoLogin()
            }
        } label: {
            Image("kakao_login")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
        }
        .cornerRadius(20)
        .padding(.horizontal)
        
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
        .clipShape(Capsule())
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.fontColor.accentColor, lineWidth: 1)
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
                    .frame(width: 25)
              
                Image("google_logo")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.colorAssets.backGroundColor)
                
               Spacer()
                    .frame(width: 4)
                 
                Text("구굴 계정으로 로그인")
                    .font(.custom(FontAsset.mediumFont, size: 20))
                    .foregroundColor(Color.fontColor.accentColor)
                
            Spacer()
            }
        }
        .frame(height: 50)
        .clipShape(Capsule())
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.fontColor.accentColor, lineWidth: 1)
        )
        .padding(.horizontal, 32)
        
    }
}

struct AnotherLoginModalView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherLoginModalView()
    }
}
