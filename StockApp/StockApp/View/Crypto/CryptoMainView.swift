//
//  CryptoMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct CryptoMainView: View {
    //MARK: - @state 및 뷰모델 선언
    @State private var showPortfolio: Bool = true                 // 오른 쪽으로 넘기는 액션
    @EnvironmentObject private var viewModel: CoinViewModel
    @State private var showPortfolioView: Bool = false       // + 버튼 누르면  bottomsheet 으로 나오게 구현
    @State private var selectionCoin: CoinModel? = nil      // 코인이  선택 되었을때
    @State private var showDetailView: Bool = false          // 다테일 뷰 보여주기 
    
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
            ScrollView(showsIndicators: false) {
                //MARK: - 상단  hedaer 부분
                homeHeader()
                    .padding(.vertical, 3)
                
                NavigationLink {
                    CryptoPortfolioView()
                } label: {
                    CryptoCoinCardView()
                }
                
                //MARK: - 마켓 시세 관련 뷰
                CryptoStatView(showPortfolio: $showPortfolio)
                    .padding(.vertical, 5)
                
                //MARK: - 코인 검색창
                SearchBarView(searchBarTextField:  $viewModel.searchText)
                //MARK: - 코인 리스트 타이틀
                columnTitles()
                //MARK:  -  코인 및 보유  시세 리스트
                allCoinList()
                    .padding(.bottom, 5)
                Spacer(minLength: .zero)
            }
        }
        .padding(.vertical)
        //MARK: - 코인을 선택해을때 네비게이션
        .background(
            NavigationLink(
                destination: CryptoDetailLoadingView(coin: $selectionCoin),
                isActive: $showDetailView,
                label: { EmptyView() }
            )
        )
//        .ignoresSafeArea()
        
    }
    //MARK: - CryptoMainView 확장으로 main body 뷰 코드를 줄이기
    //MARK: - 코인 뷰 에 상단 부분
    @ViewBuilder
    private func homeHeader()  -> some View {
        HStack {
            CircleButtonView(iconName: "plus" )
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
            Text("코인 시세")
                .spoqaHan(family: .Bold, size: 15)
                .foregroundColor(Color.fontColor.mainFontColor)
                .animation(.none)
            Spacer()
            Spacer()
        }
            .frame(height: UIScreen.main.bounds.height / 15)
            .padding(.horizontal)
    }
    //MARK:  - 코인 리스트 타이틀
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
        .spoqaHan(family: .Regular, size: 13)
        .foregroundColor(Color.colorAssets.textColor)
        .padding(.horizontal)
    }
    //MARK:  - 코인시세 리스트
    @ViewBuilder
    private func allCoinList() -> some View {
        ScrollView {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .padding(.init(top: 10, leading: .zero, bottom: 10, trailing: 10))
    }
    //MARK: - 네비게이션  segue
    private func segue(coin: CoinModel) {
        selectionCoin = coin
        showDetailView.toggle()
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

