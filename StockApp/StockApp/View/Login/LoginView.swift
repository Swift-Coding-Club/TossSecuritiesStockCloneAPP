//
//  LoginView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/07.
//

import SwiftUI

struct LoginView: View {
    @State private var emailTextField: String = ""
    @State private var passworldTextField: String = ""
    @State private var showBottomSheet: Bool = false
    @State private var saveloginInfo: Bool = false
    @State private var showmainview : Bool = false
    
    @StateObject var snsloginManager: SNSLoginManger = SNSLoginManger()
    
    @StateObject var signInviewModel: SignInViewModel = SignInViewModel()
    
    @EnvironmentObject var viewModel: SignUpVIewModel
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            .sheet(isPresented: $showBottomSheet) {
                if #available(iOS 16.0, *) {
                    AnotherLoginModalView()
                        .presentationDetents([.height(300)])
                        .ignoresSafeArea()
                } else {
                    // Fallback on earlier versions
                }
            }
            
            VStack {
                //MARK: - 로그인 상단  타이틀
                AuthHeaderView(authTopHeaderTitle: "안녕하세요",
                               authCenterHeaderTitle: "어서오세요 코인 모여 서비스에 오신걸 ",
                               authBottomHeaderTitle: "환영합니다")
                //MARK: -  이메일 및  텍스트 필드
                authorizationTextField()
                //MARK: - 비밀 번호 찾기 버튼
                forgotPasswordButton()
                //MARK: - 로그인 버튼
                loginButton()
                //MARK: - 다른 방법으로 로그인
                anotherLoginButton()
                
               Spacer()
                //MARK: - 회원 가입 버튼
                signUPButton()
                
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
       
    }
    //MARK:  -  이메일  & 비빌번호  텍스트 필드
    @ViewBuilder
    private func authorizationTextField() -> some View {
        VStack(spacing: 40) {
            CustomInputField(imageName: "envelope",
                             placeHolderText: "이메일을 입력해주세요",
                             text: $emailTextField)
            
            CustomSecureInputField(imageName: "lock",
                                   placeHolderText: "비밀 번호를 입력 해주세요",
                                   text: $passworldTextField)
        }
        .padding(.horizontal, 32)
        .padding(.top, 44)
    }
    //MARK: - 비밀 번호 찾기
    @ViewBuilder
    private func forgotPasswordButton() -> some View {
        HStack {
            Spacer()
            
            NavigationLink {
                
            } label: {
                Text("비밀 번호를 잊으셨나요 ?")
                    .font(.custom(FontAsset.mediumFont, size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.colorAssets.subColor)
                    .padding(.top)
                    .padding(.trailing, 24)
            }
        }
    }
    //MARK:  - 로그인 버튼
    @ViewBuilder
    private func loginButton() -> some View {
        Button {
            viewModel.login(withEmail: emailTextField, password: passworldTextField)
        }label: {
            Text("로그인")
                .font(.custom(FontAsset.regularFont, size: 20))
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color.colorAssets.mainColor)
                .clipShape(Capsule())
                .padding()
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: .zero, y: .zero)
    }
    //MARK: - 다른 뷰 로그인
    @ViewBuilder
    private func anotherLoginButton() -> some View {
        Button {
            showBottomSheet.toggle()
        } label: {
            Text("다른 방법으로 로그인 ")
                .font(.custom(FontAsset.regularFont, size: 20))
                .fontWeight(.semibold)
                .foregroundColor(Color.colorAssets.subColor)
        }
    }
    //MARK: - 회원가입 버튼
    @ViewBuilder
    private func signUPButton() -> some View {
        NavigationLink {
            SIgnUpVIew()
            //                        .navigationBarHidden(true)
        } label: {
            HStack {
                Text("혹시 계정이 없으신가요 ??")
                    .font(.custom(FontAsset.lightFont, size: 13))
                
                Text("회원 가입")
                    .font(.custom(FontAsset.mediumFont, size: 15))
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom , 32)
        .foregroundColor(Color.colorAssets.subColor)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
