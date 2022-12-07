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
    
    private let cryptoSearchPlaceholder: String = "검색할 코인을 입력해주세요..."
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: .zero) {
                    //MARK: - 검색 창
                    SearchBarView(searchBarTextField: $viewModel.searchText, placeholder: cryptoSearchPlaceholder)
                    //MARK: - 코인 로고
                    coinLogoList()
                    //MARK:  - 코인 서택 되었을겨우 form 보여주기
                    if selectedCoin != nil {
                        portfolioInputSection()
                    }
                }
            }
            .navigationTitle( "보유 수량 추가 하기")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    leadingNavigaionXmarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trallingNavigaionView()
                }
            })
            .onChange(of: viewModel.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
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
                ForEach(viewModel.searchText.isEmpty ? viewModel.profilioCoins : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
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
    //MARK: - 코인 업데이트
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if  let portfolioCoin = viewModel.profilioCoins.first(where: { $0.id == coin.id}),
            let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    //MARK: - 코인 수량 쓰는 form
    @ViewBuilder
    private func portfolioInputSection() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("보유한 코인 \(selectedCoin?.symbol.uppercased() ?? "" ) : ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2DecimalsValue() ?? "") +
                Text(" KRW")
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
                Text(getCurrentValue().asCurrencyWith2DecimalsValue() + " KRW")
            }
        }
        .animation(.none)
        .padding()
        .spoqaHan(family: .Medium, size: 15)
    }
    //MARK: - navigaionleadingtoolbar xmark button
    @ViewBuilder
    private func leadingNavigaionXmarkButton() -> some View {
        Button {
            dismiss()
        }label: {
            Image(systemName: "xmark")
        }
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
                (selectedCoin != nil  && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : .zero)
        }
        .font(.custom(FontAsset.mediumFont, size: 15))
    }
    //MARK: - save button 눌렀을때 실행 되는
    private func savedButtonPressed() {
        guard
            let coin  = selectedCoin,
            let amont = Double(quantityText) else { return }
        
        // saved 코인
        viewModel.updatePortfolio(coin: coin, amount: amont)
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
