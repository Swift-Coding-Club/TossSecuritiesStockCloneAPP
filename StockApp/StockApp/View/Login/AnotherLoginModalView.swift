//
//  AnotherLoginModalView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

struct AnotherLoginModalView: View {
    @Environment (\.dismiss) private var dismiss
    
    @StateObject var snsloginManager: SNSLoginManger = SNSLoginManger()
    @StateObject var signInviewModel: SignInViewModel = SignInViewModel()
    @State private var mainTabview: Bool = false
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            //            .fullScreenCover(isPresented: $mainTabview) {
            //                MainTabVIew(view: $mainTabview)
            //            }
            NavigationView {
                VStack {
                    //MARK: - 창을  닫는 버튼
                    closeViewButton()
                    
                    kakoLoginImage()
                    
                    Spacer(minLength: .zero)
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func kakoLoginImage() -> some View {
        Button {
            snsloginManager.snsCallback = {(userid , email, acessToken) in
                signInviewModel.signIn(userid, email: email, provider: SignType.kakao, saveLogInInfo: false)
                
            }
            
            snsloginManager.kakoLogin()
            
        } label: {
            Image("kakao_login")
                .resizable()
                .frame(height: 50)
                .scaledToFit()
        }
        .cornerRadius(20)
        .padding(.horizontal)
        
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
}

struct AnotherLoginModalView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherLoginModalView()
    }
}
