//
//  ErrorStateView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import SwiftUI

struct ErrorStateView: View {
    let error : String
    var retryCallback: ( () -> ())? = nil
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 14) {
                Text(error)
                if let retryCallback {
                    Button("다시 시도 해주세요", action: retryCallback)
                        .spoqaHan(family: .Bold, size: 15)
                        .padding(12)
                        .foregroundColor(Color.white)
                        .background(Color.colorAssets.skyblue4.opacity(0.8))
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding(64)
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ErrorStateView(error: "에러가 발생했어요")  { }
                .previewDisplayName("with retry button")
            
            ErrorStateView(error: "에러가 발생했어요")
                .previewDisplayName("with retry button")
        }
    }
}
