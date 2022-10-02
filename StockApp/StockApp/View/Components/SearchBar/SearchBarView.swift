//
//  SearchBarView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchBarTextField: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchBarTextField.isEmpty ? Color.colorAssets.textColor :
                        Color.fontColor.accentColor
                )
            
            TextField("검색힐 코인을 입력해주세요...", text: $searchBarTextField)
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
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
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
            SearchBarView(searchBarTextField: .constant(""))
                .previewLayout(.sizeThatFits)
            SearchBarView(searchBarTextField: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }
}
