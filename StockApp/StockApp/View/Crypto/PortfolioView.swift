//
//  PortfolioView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/26.
//

import SwiftUI

struct PortfolioView: View {
    
    
    @Environment(\.dismiss) private var dismiss    // dismiss 하는 환견변수
    @EnvironmentObject  private var viewModel: CoinViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: .zero) {
                    //MARK: - 검색 창
                    SearchBarView(searchBarTextField: $viewModel.searchText)
                    //MARK: - 코인 로고
                   coinLogoList()
                    
                    if selectedCoin != nil {
                        portfolioInputSection()
                    }
                }
            }
            .navigationTitle( "보유 수량 추가 하기")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trallingNavigaionView()
                }
            })
        }
    }
    
    //MARK: - 총합 구하는 수량
    private func getCurrentValue() -> Double {
        if let quamtity = Double(quantityText) {
            return quamtity * (selectedCoin?.currentPrice ?? .zero )
        }
        return .zero
    }
    
    //MARK: - 코인 로고 viewBuilder
    @ViewBuilder
    private func coinLogoList() -> some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                   CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coin.id ? Color.colorAssets.navy : Color.clear , lineWidth: 1)
                        )
                }
            }
            .frame(height:  120)
            .padding(.leading)
        }
    }
    //MARK: - 코인 수량 쓰는 form
    @ViewBuilder
    private func portfolioInputSection() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("보유한 코인 \(selectedCoin?.symbol.uppercased() ?? "" ) : ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                }
            Divider()
            
            HStack {
                Text("보유 하고 있는 코인의 금액 : ")
                Spacer()
                TextField("예시 : 1.4 ", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("코인 총합 : ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.custom(FontAsset.mediumFont, size: 15))
    }
    //MARK:  - bottom tralling navigaion view
    @ViewBuilder
    private func trallingNavigaionView() -> some View {
        HStack (spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 :  0.0)
            Button {
                savedButtonPressed()
            }label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil  && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
        .font(.custom(FontAsset.mediumFont, size: 15))
    }
    //MARK: - save button 눌렀을때 실행 되는
    private func savedButtonPressed() {
        guard let coin  = selectedCoin else { return }
        
         // saved 코인
          
        //  체크 마크 보여주기
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        // 키보드 숨기기
        UIApplication.shared.endEditing()
        
        // 다시 체크 마크 숨기기
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) {
            withAnimation(.easeInOut) {
                showCheckMark = false
            }
        }
    }
    //MARK: - 코인 삭제 함수
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.coinViewModel)
    }
}
