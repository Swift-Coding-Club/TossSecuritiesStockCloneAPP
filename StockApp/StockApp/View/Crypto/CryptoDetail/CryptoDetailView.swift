//
//  CryptoDetailView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/30.
//

import SwiftUI

struct CryptoDetailView: View {
    @StateObject private  var viewModel: CryptoDetailViewModel   // 코인 디테일 뷰 관련
    private let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())]     // griditem 관련
    private let spacing: CGFloat = 30    // griditem spacing 관련
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CryptoDetailViewModel(coin: coin))
        debugPrint(" inititaling  detail view  : \(coin.name)")
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                
                Text("코인 설명")
                    .font(.custom(FontAsset.mediumFont, size: 25))
                    .bold()
                    .foregroundColor(Color.fontColor.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(columns: colums,
                          alignment: .leading,
                          spacing:  spacing,
                          pinnedViews: [ ] ) {
                    ForEach(0..<6) { _ in
                        StatisticView(stat: StatisticModel(title: "title", value: "value"))
                    }
                }
                
                Text("추가 세부 사항")
                    .font(.custom(FontAsset.mediumFont, size: 25))
                    .bold()
                    .foregroundColor(Color.fontColor.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(columns: colums,
                          alignment: .leading,
                          spacing:  spacing,
                          pinnedViews: [ ] ) {
                    ForEach(0..<6) { _ in
                        StatisticView(stat: StatisticModel(title: "title", value: "value"))
                    }
                }
                
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CryptoDetailView(coin: dev.coin)
        }
    }
}
