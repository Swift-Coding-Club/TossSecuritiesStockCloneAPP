//
//  LoginView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/07.
//

import SwiftUI

struct LoginView: View {
    @State private var emailText: String = ""
    @State private var passworldText: String = ""
    @State private var showBottomSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
              backgroundColor()
                
                VStack {
                    Spacer()
                        .frame(height: 100)
                    
                    topViewTitle()
                
                    Spacer()
                        .frame(height: 100)
                    
                    emailTextField()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    passworldTextField()
                    
                    Spacer()
                        .frame(height: 40)
                    
                    authorizationButton()
                    
                    Spacer(minLength: .zero)
                }
            }
        }
    }
    //MARK: -  배경 색상
    @ViewBuilder
    private func backgroundColor() -> some View {
        LinearGradient(gradient: Gradient(colors: [Color.colorAssets.skyblue2, Color.colorAssets.white]),
                                startPoint: .top, endPoint: .leading)
        .ignoresSafeArea(.all)
    }
    //MARK:  - 이메일  로그 타이틀
    @ViewBuilder
    private func topViewTitle() -> some View {
        HStack {
            Text (" 로그인  창 ")
                .font(.custom(FontAsset.mediumFont, size: 25))
        }
    }
    //MARK:  -  이메일  텍스트 필드
    @ViewBuilder
    private func emailTextField() -> some View {
        VStack {
            TextField("이메일 및 아이디 로그인 ", text: $emailText)
                .foregroundColor(Color.fontColor.mainFontColor)
                .font(.custom(FontAsset.mediumFont, size: 20))
                .frame(height: 50)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.colorAssets.backGroundColor)
                .shadow(color: Color.fontColor.accentColor.opacity(0.15), radius: 10, x: .zero, y: .zero)
        )
        .padding(.horizontal, 5)
    }
    //MARK: - 비빌 번호  텍스트 필드
    @ViewBuilder
    private func passworldTextField() -> some View {
        VStack {
            SecureField("비밀 번호 로그인  ", text: $passworldText)
                .foregroundColor(Color.fontColor.mainFontColor)
                .font(.custom(FontAsset.mediumFont, size: 20))
                .frame(height: 50)
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.colorAssets.backGroundColor)
                .shadow(color: Color.fontColor.accentColor.opacity(0.15), radius: 10, x: .zero, y: .zero)
        )
    }
    //MARK:  - 로그인 및 회원 가입 버튼
    @ViewBuilder
    private func  authorizationButton() -> some View {
        HStack {
            Button {
                showBottomSheet.toggle()
            } label: {
                Text("로그인 ")
                    .font(.custom(FontAsset.mediumFont, size: 20))
                    .foregroundColor(Color.fontColor.mainFontColor)
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            ClosedButtonView()
                .presentationDetents([.height(500)])
        }
        .cornerRadius(100)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
