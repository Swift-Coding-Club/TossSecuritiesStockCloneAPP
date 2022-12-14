//
//  SearchBarView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/25.
//

import SwiftUI
import Introspect

struct SearchBarView: View {
    @Binding var searchBarTextField: String
    @State var uiTabarController: UITabBarController?
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchBarTextField.isEmpty ? Color.colorAssets.textColor :
                        Color.fontColor.accentColor
                )
//            "검색힐 코인을 입력해주세요..."
            TextField(placeholder, text: $searchBarTextField)
                .foregroundColor(Color.fontColor.accentColor)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.fontColor.accentColor)
                        .opacity(searchBarTextField.isEmpty ? .zero : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchBarTextField = ""
                        }
                    ,alignment: .trailing
                )
                .introspectTabBarController { (UITabBarController) in
                    UITabBarController.tabBar.isHidden = true
                    uiTabarController = UITabBarController
                }.onDisappear{
                    uiTabarController?.tabBar.isHidden = true
                }
        }
        .spoqaHan(family: .Medium, size: 15)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.colorAssets.backGroundColor)
                .shadow(
                    color: Color.fontColor.accentColor.opacity(0.15),
                    radius: 10, x: .zero, y: .zero)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchBarTextField: .constant(""), placeholder: "검색힐 코인을 입력해주세요...")
                .previewLayout(.sizeThatFits)
            SearchBarView(searchBarTextField: .constant(""), placeholder: "검색힐 주식 입력해주세요...")
                .previewLayout(.sizeThatFits)
        }
    }
}
