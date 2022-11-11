//
//  PopupView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/23.
//

import SwiftUI

struct PopupView: View {
    private var title: String = "로그아웃 하시겠어요"
    private var message: String = "로그아웃 하셔도 코인모야는 유저님을 기다립니다"
    private var cancelTitle: String = "취소"
    private var confiremTitle: String = "확인"
    
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @State var closedAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            customAlertTitle()
            
            Spacer()
                .frame(height: 22)
            
            alertConfirmButton()
        }
        .padding(EdgeInsets(top: 40, leading: 30, bottom: 31, trailing: 30))
        .frame(width: ContentsWidth, height: 200)
        .background(Color.colorAssets.navy2)
        .cornerRadius(30.0)
        .shadow(color: Color.fontColor.accentColor, radius: 6, x: 0, y: .zero)
        .animation(.easeOut)
        .edgesIgnoringSafeArea(.all)
    }
    //MARK: - 알림창  타이틀 및  메세지
    @ViewBuilder
    private func customAlertTitle() -> some View {
        Text(title)
            .kerning(-0.36)
            .spoqaHan(family: .Medium, size: 22)
            .foregroundColor(Color.colorAssets.white2)
            .frame(width: ContentsWidth - 60)
        
        Spacer()
            .frame(height: 13)
        
        Text(message)
            .kerning(-0.3)
            .spoqaHan(family: .Regular, size: 18)
            .foregroundColor(Color.colorAssets.white)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .frame(width: ContentsWidth-60)
    }

    //MARK: -  알림 버튼 취소 확인 버튼
    @ViewBuilder
    private func alertConfirmButton() -> some View {
        HStack {
            Button {
                self.closedAlert = false
            } label: {
                Text(cancelTitle)
                    .kerning(-0.34)
                    .spoqaHan(family: .Bold, size: 18)
                    .foregroundColor(Color.colorAssets.white2)
                    .frame(width: 140, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 1)
                            .frame(width: 140, height: 40)
                    )
            }
            .frame(width: 140, height: 40)
//            .background(Color.colorAssets.white)
            .cornerRadius(30.0)
            .shadow(color: Color.colorAssets.white.opacity(0.4), radius: 6, x: 0, y: 3)
            
            Spacer()
                .frame(width: 30)
            
            Button {
                viewModel.signOut()
            } label: {
                Text(confiremTitle)
                    .kerning(-0.34)
                    .spoqaHan(family: .Bold, size: 18)
                    .foregroundColor(Color.colorAssets.subColor)
                    .frame(width: 140, height: 40)
            }
            .frame(width: 140, height: 40)
            .background(Color.colorAssets.white)
            .cornerRadius(30.0)
            .shadow(color: Color.colorAssets.white.opacity(0.4), radius: 6, x: 0, y: 3)
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
            .environmentObject(dev.signUpViewModel)
    }
}
