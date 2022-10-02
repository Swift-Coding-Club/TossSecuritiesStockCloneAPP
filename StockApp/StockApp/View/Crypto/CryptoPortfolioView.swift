//
//  CryptoPortfolioView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/02.
//

import SwiftUI

struct CryptoPortfolioView: View {
    @EnvironmentObject private var viewModel: CoinViewModel
    @State private var showPortfolio: Bool = true
    @State private var showPortfolioView: Bool = false       // + 버튼 누르면  bottomsheet 으로 나오게 구현
    @State private var selectionCoin: CoinModel? = nil      // 코인이  선택 되었을때
    @State private var showDetailView: Bool = false          // 다테일 뷰 보여주기
    
    
    var body: some View {
       
        NavigationView {
            ZStack {
                //MARK: - 배경 색상 관련
                Color.colorAssets.backGroundColor
                    .ignoresSafeArea()
                //MARK: - 코인 보유 시세
                VStack(alignment: .leading) {
                    cryptoHeader()
                        .padding(.horizontal, 10)
                    cryptoCoinItems()
                    //MARK: - 마켓 시세 관련 뷰
                    CryptoCoinCardView()
                        .padding(.vertical)
                    //MARK: - 코인 검색창
                    SearchBarView(searchBarTextField:  $viewModel.searchText)
                    //MARK: - 코인 리스트 타이틀
                    columnTitles()
                    //MARK:  -  코인 보유 시세
                    protfolioCoinList()
                    Spacer(minLength: .zero)
                }
            }
        }
    }
    
    @ViewBuilder
    private func cryptoHeader() -> some View {
        VStack {
            Text("코인 보유 수량")
                   .font(.custom(FontAsset.mediumFont, size: 25))
                   .fontWeight(.heavy)
                   .foregroundColor(Color.colorAssets.subColor)
        }
        .frame(height: UIScreen.main.bounds.height / 15)
    }
    @ViewBuilder
    private func cryptoCoinItems() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16){
                ForEach(viewModel.profilioCoins) { portfolioCoin in
                    CryptoCoinItemViews(coin: portfolioCoin)
                }
            }
        }
    }
    @ViewBuilder
    private func columnTitles() -> some View {
        HStack {
            HStack(spacing: 4) {
                Text("코인")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : .zero)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? .zero : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            HStack(spacing: 4) {
                Text("보유수량")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1.0 : .zero)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? .zero : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
            HStack(spacing: 4) {
                Text("가격")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : .zero)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? .zero : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button{
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            }label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : .zero),
                            anchor: .center)
        }
        .font(.custom(FontAsset.regularFont, size: 13))
        .foregroundColor(Color.colorAssets.textColor)
        .padding(.horizontal)
    }
    @ViewBuilder
    private func protfolioCoinList() -> some View {
        List {
            ForEach(viewModel.profilioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: .zero, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    //MARK: - 네비게이션  segue
    private func segue(coin: CoinModel) {
        selectionCoin = coin
        showDetailView.toggle()
    }
}

struct CryptoPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoPortfolioView()
            .environmentObject(dev.coinViewModel)
    }
}
