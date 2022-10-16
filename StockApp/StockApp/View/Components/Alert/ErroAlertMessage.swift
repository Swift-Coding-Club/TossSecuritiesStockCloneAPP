//
//  ErroAlertMessage.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/15.
//

import SwiftUI

struct ErroAlertMessage: ViewModifier {
    var isPresented: Binding<Bool>
    let message: String
    
    func body(content: Content) -> some View {
        content.alert(isPresented: isPresented) {
            Alert(title: Text("로그인이 잘못 되었어요 ")
                .font(.custom(FontAsset.mediumFont, size: 15))
                .foregroundColor(Color.fontColor.mainFontColor),
            message: Text(message)
                .font(.custom(FontAsset.mediumFont, size: 15))
                .foregroundColor(Color.fontColor.mainFontColor),
                  dismissButton: .cancel(Text("확인")
                    .font(.custom(FontAsset.mediumFont, size: 13))
                    .foregroundColor(Color.fontColor.mainFontColor))
            )
        }
    }
}

extension View {
    func showErrorAlertMessage(showAlert: Binding<Bool>, message: String) -> some View {
        self.modifier(CheckRegisterAlert(isPresented: showAlert, message: message))
    }
}
