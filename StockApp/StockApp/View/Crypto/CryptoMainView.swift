//
//  CryptoMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct CryptoMainView: View {
    //MARK: - @state 및 뷰모델 선언
    @State private var showPortfolio: Bool = true       // 오른 쪽으로 넘기는 액션
    @EnvironmentObject private var viewModel: CoinViewModel
    @State private var showPortfolioView: Bool = false       // + 버튼 누르면  bottomsheet 으로 나오게 구현
    
    //MARK: - 뷰를 그리는 곳
    var body: some View {
        ZStack {
            //MARK: - 배경 색상 관련
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(viewModel)
                }
            
            //MARK: - 각 뷰에 관련 된 부분
            VStack {
                //MARK: - 상단  hedaer 부분
                homeHeader
                //MARK: - 마켓 시세 관련 뷰
                CryptoStatView(showPortfolio: $showPortfolio)
                //MARK: - 코인 검색창
                SearchBarView(searchBarTextField:  $viewModel.searchText)
                //MARK: - 코인 리스트 타이틀
                columnTitles
                //MARK:  -  코인 및 보유  시세 리스트
                if !showPortfolio {
                    allCoinList
                        .transition(.move(edge: .leading))
                        .padding(.bottom, 5)
                } else {
                    protfolioCoinList
                        .padding(.bottom, 5)
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: .zero)
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
        .environmentObject(dev.coinViewModel)
    }
}

//MARK: - CryptoMainView 확장으로 main body 뷰 코드를 줄이기
extension CryptoMainView {
    //MARK: - 코인 뷰 에 상단 부분
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationVIew(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "보유 수량" : "코인 시세")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.fontColor.accentColor)
                .animation(.none)
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
    //MARK:  - 코인 리스트 타이틀
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("코인")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
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
    //MARK:  - 코인시세 리스트
    private var allCoinList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: .zero, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    //MARK: -   보유 수량 코인 리스트
    private var protfolioCoinList: some View {
        List {
            ForEach(viewModel.profilioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: .zero, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
}
