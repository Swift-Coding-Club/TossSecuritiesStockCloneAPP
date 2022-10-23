//
//  HomeView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: CoinViewModel
    @State private var selectionCoin: CoinModel? = nil      // 코인이  선택 되었을때
    @State private var showDetailView: Bool = false          // 다테일 뷰 보여주기
    
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            ScrollView {
                //MARK: - 모든 코인 리스트
                coinListHeader()
                Divider()
                coinList()
                Spacer()
                    .frame(height: 30)
                portfolioHeader()
                Divider()
                portfolioCoinList()
                Spacer()
                    .frame(height: 20)
            }
        }
        
    }
    
    //MARK: - 코인 리스트 혜더
    @ViewBuilder
    private func coinListHeader() -> some View {
        HStack {
            Text("코인 리스트 ")
                .font(.custom(FontAsset.mediumFont, size: 15))
                .foregroundColor(Color.fontColor.mainFontColor)
            Spacer()
            
            NavigationLink {
                CryptoMainView()
            } label: {
                Text("더보기")
                    .font(.custom(FontAsset.mediumFont, size: 15))
                    .foregroundColor(Color.colorAssets.mauvepurple2)
                    .padding()
            }
        }
        .frame(height: 20)
        .padding(.leading)
        .padding(.vertical, 5)
    }
    //MARK: - 코인  리스트 상위에서 5개만
    @ViewBuilder
    private func coinList() -> some View {
        ScrollView {
            ForEach(viewModel.allCoins.filter{$0.rank  < 6 }) {coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
            }
        }
        .padding(.horizontal)
    }
    //MARK: - 보유한 코인 리스트
    @ViewBuilder
    private func portfolioHeader() -> some View {
        HStack {
            Text("보유한 코인 리스트 ")
                .font(.custom(FontAsset.mediumFont, size: 20))
                .foregroundColor(Color.fontColor.mainFontColor)
            Spacer()
            
            NavigationLink {
                CryptoPortfolioView()
            } label: {
                Text("더보기")
                    .font(.custom(FontAsset.mediumFont, size: 15))
                    .foregroundColor(Color.colorAssets.mauvepurple2)
                    .padding()
            }
        }
        .frame(height: 20)
        .padding(.leading)
        .padding(.vertical, 5)
    }
    //MARK: - 보유한 코인의 리스트  5개 이상이면  5개  이하만  나오게 구현
    @ViewBuilder
    private func portfolioCoinList() -> some View {
        ScrollView {
            ForEach(viewModel.profilioCoins.filter{$0.rank  < 6 }) {coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
            }
        }
        .padding(.horizontal)
    }
    //MARK: - 코인을 눌렀을때 코인세부 페이지로 이동
    private func segue(coin: CoinModel) {
        selectionCoin = coin
        showDetailView.toggle()
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(dev.coinViewModel)
        }
    }
}
