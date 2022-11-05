//
//  LoginView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/07.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var emailTextField: String = ""
    @State private var passworldTextField: String = ""
    @State private var showBottomSheet: Bool = false
    @State private var saveloginInfo: Bool = false
    @State private var showmainview : Bool = false
    
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorAssets.backGroundColor
                    .ignoresSafeArea()
                VStack {
                    
                    Spacer()
                        .frame(height: 30)
                    
                    loginViewTitle()
                    
                    authorizationTextField()
                    
                    spacerView(height: 15)
                    
                    forgotPasswordButton()
                    
                    spacerView(height: 20)
                    
                    loginButton()
                    
                    spacerView(height: 20)
                    
                    signUPButton()
                    
                    Spacer(minLength: .zero)
                }
                .navigationBarHidden(true)
                
            }
        }
    }
    
    //MARK: - 로그인 뷰 상단  타이틀
    @ViewBuilder
    private func loginViewTitle() -> some View {
        HStack{
            Text("Coin Moya")
                .spoqaHan(family: .Bold, size: 30)
                .foregroundColor(Color.fontColor.mainFontColor)
            
            Rectangle()
                    .frame(width: 15, height: 15)
                    .rotationEffect(Angle(degrees: 130))
                    .foregroundColor(Color.colorAssets.skyblue4)
                    .offset(y: -15)
        }
        .padding(.bottom, 20)
        .padding()
    }

    //MARK:  -  이메일  & 비빌번호  텍스트 필드
    @ViewBuilder
    private func authorizationTextField() -> some View {
        VStack(spacing: 40) {
            CustomInputField(imageName: "envelope",
                             placeHolderText: "이메일",
                             text: $emailTextField)
            
            CustomSecureInputField(imageName: "lock",
                                   placeHolderText: "비밀 번호",
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
                ForgotPasswordView()
            } label: {
                Text("비밀 번호를 잊으셨나요 ?")
                    .spoqaHan(family: .Bold, size: 15)
                    .foregroundColor(Color.colorAssets.navy2)
                    .padding(.top)
                    .padding(.trailing, 24)
            }
        }
        .padding(.horizontal, 25)
    }
    //MARK:  - 로그인 버튼
    @ViewBuilder
    private func loginButton() -> some View {
        Button {
            viewModel.login(withEmail: emailTextField, password: passworldTextField)
        }label: {
            Text("로그인")
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color.colorAssets.navy2)
                .cornerRadius(15)
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: .zero, y: .zero)
    }
    //MARK: - 회원가입 버튼
    @ViewBuilder
    private func signUPButton() -> some View {
        NavigationLink {
            SIgnUpVIew()
            //                        .navigationBarHidden(true)
        } label: {
            Text("회원 가입 하기")
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color.colorAssets.darkblue)
                .cornerRadius(15)
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: .zero, y: .zero)
    }
    
    @ViewBuilder
    private func spacerView(height: CGFloat) -> some View {
        Spacer()
            .frame(height: height)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
