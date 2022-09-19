//
//  CryptoMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct CryptoMainView: View {
    //MARK: - @state 및 뷰모델 선언
    @State private var showPortfolio: Bool = false

    //MARK: - 뷰를 그리는 곳
    var body: some View {
        ZStack {
            //MARK: - 배경 색상 관련
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            
            //MARK: - 각 뷰에 관련 된 부분
            VStack {
                HStack {
                    CircleButtonView(iconName: "info")
                    Spacer()
                    Text("코인 시세")
                        .font(.custom(FontAsset.mediumFont, size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.fontColor.accentColor)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showPortfolio.toggle()
                            }
                        }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CryptoMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CryptoMainView()
                .navigationBarHidden(true)
        }
    }
}
