//
//  CryptoDetailView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/30.
//

import SwiftUI

struct CryptoDetailView: View {
    @StateObject private  var viewModel: CryptoDetailViewModel   // 코인 디테일 뷰 관련
    @State private var showFullDescription: Bool = false    // 코인 설명  더보기
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
            VStack {
                //MARK:  - 차트 뷰
                CryptoChartView(coin: viewModel.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    //MARK: - 코인 개요
                    overViewTitle()
                    //MARK: - 코인 개용 설명
                    descriptionSection()
                    //MARK: - 코인 개요 부분 grid
                    overViewGrid()
                    //MARK: - 추가 세부 사항
                    additionalTitle()
                    //MARK: - 추가 세부 사항 grid
                    additionalGrid()
                    //MARK:  - 코인 홈페이지 링크
                    webSiteSection()
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrallingItem()
            }
        }
    }
    //MARK: - toolbar item
    @ViewBuilder
    private func navigationBarTrallingItem() -> some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.custom(FontAsset.regularFont, size: 20))
                .foregroundColor(Color.colorAssets.textColor)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    //MARK: - 코인 개요 타이틀
    @ViewBuilder
    private func overViewTitle() -> some View {
        Text("코인 개요")
            .font(.custom(FontAsset.mediumFont, size: 25))
            .bold()
            .foregroundColor(Color.fontColor.mainFontColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
    }
    //MARK: - 코인 자세한 설명 관련
    @ViewBuilder
    private func descriptionSection() -> some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.custom(FontAsset.regularFont, size: 14))
                        .foregroundColor(Color.colorAssets.textColor)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "접기" : "더 보기...")
                            .font(.custom(FontAsset.mediumFont, size: 15))
                            .fontWeight(.bold)
                            .padding(.vertical , 4)
                    }
                    .accentColor(Color.colorAssets.subColor)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
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
            .foregroundColor(Color.fontColor.mainFontColor)
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
    //MARK: - 코인 웹사이트
    @ViewBuilder
    private func webSiteSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            if let website = viewModel.webSiteURL,
               let url = URL(string: website) {
                Link("webSIte", destination: url)
            }
            if let redditString = viewModel.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(Color.colorAssets.subColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.custom(FontAsset.mediumFont, size: 15))
    }

}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CryptoDetailView(coin: dev.coin)
        }
    }
}
