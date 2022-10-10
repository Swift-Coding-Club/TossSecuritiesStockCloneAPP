//
//  AnotherLoginModalView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/10.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

struct AnotherLoginModalView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject var snsloginManager: SNSLoginManger = SNSLoginManger()
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                //MARK: - 창을  닫는 버튼
                closeViewButton()
                
                HStack {
                    
                    Button {
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
                Spacer(minLength: .zero)
            }
        }
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
