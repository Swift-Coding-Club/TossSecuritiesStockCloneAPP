//
//  HomeView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @EnvironmentObject private var viewModel: CoinViewModel
   
    @StateObject var stockViewModel: StockViewModel
    
    @State private var selectedCoin: HomeCoinConverTitleViewModel = .coinList
    
    @State private var selectStock: HomeConverStockViewModel = .nsd
    
    @State private var coinView: Bool = false
    @State private var showDetailCoinView: Bool = false
    @State private var showDetailView: Bool = false          // 다테일 뷰 보여주기
    @State private var selectionCoin: CoinModel? = nil      // 코인이  선택 되었을때
    @State private var showCryptoView: Bool = false
    @State private var selectedCoinDetailView: CoinModel? = nil
    
    
    @Namespace var animation
    @Namespace var animations
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            VStack{
                //MARK: - 코인 헤더
                coinHeader()
                
                ScrollView {
                    //MARK: - 코인 헤더 리스트
                    selectedCoinList()
                    Spacer()
                        .frame(height: 40)
                    //MARK: - 주식 헤더
                    stockHeader()
                    //MARK: - 주식 헤더 리스트
                    stockList()

                    Spacer().frame(height: 100)
                }
                .bounce(false)
            }
        }
        .background(
            NavigationLink(destination: CryptoMainView(showView: $coinView), isActive: $showDetailView, label: {EmptyView()})
        )
        .background(NavigationLink(destination: CryptoDetailLoadingView(coin: $selectedCoinDetailView), isActive: $showDetailCoinView, label: {EmptyView()})
        )
    }
    
    @ViewBuilder
    private func coinHeader() -> some View {
        HStack {
            ForEach(HomeCoinConverTitleViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Spacer()
                        .frame(height: 10)
                    Text(item.description)
                        .spoqaHan(family: .Medium, size: 20)
                        .foregroundColor(selectedCoin == item ? Color.fontColor.mainFontColor : .gray)
                    
                    if selectedCoin ==  item {
                        Capsule()
                            .foregroundColor(Color.colorAssets.blue3)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "coin", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 2)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedCoin = item
                    }
                }
            }
        }
    }
    //MARK: - 코인 리스트 혜더
   @ViewBuilder
    private func selectedCoinList() -> some View {
        if selectedCoin == .coinList {
            coinList()
        } else if selectedCoin == .myCoin {
            portfolioCoinList()
        }
    }
    //MARK: - 코인  리스트 상위에서 5개만
    @ViewBuilder
    private func coinList() -> some View {
        ScrollView {
            ForEach(viewModel.allCoins.filter{$0.rank  < 6 }) {coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .padding(.horizontal)
    }
    //MARK: - 보유한 코인의 리스트  5개 이상이면  5개  이하만  나오게 구현
    @ViewBuilder
    private func portfolioCoinList() -> some View {
        if viewModel.profilioCoins.isEmpty {
            VStack(alignment: .center){
                Spacer().frame(height: 120)
                
                Text("보유한  코인이 없어요")
                    .spoqaHan(family: .Medium, size: 20)
                    .foregroundColor(Color.fontColor.mainFontColor)
                
                Spacer()
                    .frame(height: 30)
                
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showCryptoView.toggle()
                    }
                } label: {
                    Text("코인을  추가 해보러  갈까요??")
                        .spoqaHan(family: .Bold, size: 20)
                        .frame(width: 340, height: 50)
                        .background(Color.colorAssets.navy2.opacity(0.8))
                        .cornerRadius(15)
                        .foregroundColor(Color.white)
                }
                .background(
                NavigationLink(
                                destination: CryptoMainView(showView: $showCryptoView),
                                isActive: $showCryptoView,
                               label: {EmptyView()})
                )
                Spacer()
                    .frame(height: 90)
            }
        } else {
            ScrollView {
                ForEach(viewModel.profilioCoins.filter{$0.rank  < 6 }) {coin in
                    CoinRowView(coin: coin, showHoldingsColumn: true)
                        .onTapGesture {
                            segueDetail(coin: coin)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    //MARK: - 코인을 눌렀을때 코인세부 페이지로 이동
    private func segue(coin: CoinModel) {
        selectionCoin = coin
        showDetailView.toggle()
    }
    //MARK: - 코인을 눌렀을때 코인세부 차트  페이지로 이동
    private func segueDetail(coin: CoinModel) {
        selectedCoinDetailView = coin
        showDetailCoinView.toggle()
    }
    //MARK: - 주식  헤더
    @ViewBuilder
    private func stockHeader() -> some View {
        HStack {
            ForEach(HomeConverStockViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Spacer()
                        .frame(height: 10)
                    Text(item.description)
                        .spoqaHan(family: .Medium, size: 20)
                        .foregroundColor(selectStock == item ? Color.fontColor.mainFontColor : .gray)
                    
                    if selectStock ==  item {
                        Capsule()
                            .foregroundColor(Color.colorAssets.blue3)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "stock", in: animations)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 2)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectStock = item
                    }
                }
            }
        }
    }
    //MARK:  주식 리스트
    @ViewBuilder
    private func stockList() -> some View {
        if selectStock == .nsd {
            StockRowBestView(stockViewModel: stockViewModel, symbol: StockSymbol.nsdSymbolBest5.description)
        } else if selectStock == .newyork {
            StockRowBestView(stockViewModel: stockViewModel, symbol: StockSymbol.newyorkSymbolBest5.description)
        }
    }

 
}

@available(iOS 16.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(stockViewModel: StockViewModel())
                .environmentObject(dev.coinViewModel)
        }
    }
}
