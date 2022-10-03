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
                    .frame(height: 250)
                //MARK: - 코인 개요
                overViewTitle()
                //MARK: - 코인 개요 부분 grid
                overViewGrid()
                //MARK: - 추가 세부 사항
                additionalTitle()
                //MARK: - 추가 세부 사항 grid
                additionalGrid()
                
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
    //MARK: - 코인 개요 타이틀
    @ViewBuilder
    private func overViewTitle() -> some View {
        Text("코인 개요")
            .font(.custom(FontAsset.mediumFont, size: 25))
            .bold()
            .foregroundColor(Color.fontColor.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
    }
    //MARK: - 코인 개요 Grid
    @ViewBuilder
    private func overViewGrid() -> some View {
        LazyVGrid(columns: colums,
                  alignment: .leading,
                  spacing:  spacing,
                  pinnedViews: [ ] ) {
            ForEach(viewModel.overViewStatistics) { stat in
               StatisticView(stat: stat)
            }
        }
    }
    //MARK: - 코인 추가 설명 타이틀
    @ViewBuilder
    private func additionalTitle() -> some View {
        Text("추가 세부 사항")
            .font(.custom(FontAsset.mediumFont, size: 25))
            .bold()
            .foregroundColor(Color.fontColor.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
    }
    //MARK: - 코인 추가 사항 grid
@ViewBuilder
    private func additionalGrid() -> some View {
        LazyVGrid(columns: colums,
                  alignment: .leading,
                  spacing:  spacing,
                  pinnedViews: [ ] ) {
            ForEach(viewModel.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
        }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CryptoDetailView(coin: dev.coin)
        }
    }
}
