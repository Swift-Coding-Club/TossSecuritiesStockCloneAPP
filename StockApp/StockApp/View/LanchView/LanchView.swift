//
//  LanchView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/04.
//

import SwiftUI

struct LanchView: View {
    
    //MARK: - 프로 그래스 뷰 로드
    @State private var loadingProgress: Double  = .zero
    let timer = Timer.publish(every: 0.1, on:  .main, in: .common).autoconnect()
    @Binding var showLanchView: Bool
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            
            VStack{
              Spacer()
                
                lanchViewTitle()
                
                Spacer()
                    .frame(height: 20)
                
                //MARK: - 프로그래스 뷰
                ProgressView(value: loadingProgress, total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.colorAssets.mainColor2))
                    .padding()
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            .onReceive(timer) { _ in
                if loadingProgress < 100 {
                    loadingProgress += 5
                } else {
                    showLanchView = false
                }
            }
        }
    }
    @ViewBuilder
    private func lanchViewTitle() -> some View {
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
}

struct LanchView_Previews: PreviewProvider {
    static var previews: some View {
        LanchView(showLanchView: .constant(false))
    }
}
