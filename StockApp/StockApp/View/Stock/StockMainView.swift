//
//  StockMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct StockMainView: View {
    @Namespace var animation
    @State var selectStock : StockConvertViewModel = .most
    @StateObject var stockMostViewModel: StockMostViewModel
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 20)
                
                stockHeader()
                
                convertTitle()
                
                ScrollView(.vertical , showsIndicators: false) {
                    
                    stockListTitle()
                    
                    stockConvertList()
                        .padding(.bottom, 12)
                }
                .bounce(false)
                .padding(.vertical , 30)
                
                Spacer(minLength: .zero)
            }
        }
    }
    //MARK: - 주식 관련 타이틀
    @ViewBuilder
    private func stockHeader() -> some View {
        HStack(alignment: .center) {
            Text("해외주식")
                .spoqaHan(family: .Bold, size: 25)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
        Spacer().frame(height: 15)
    }
    //MARK: - 주식 검색
    
    //MARK: - 주식  전환 타이틀
    @ViewBuilder
    private func convertTitle() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                    .frame(width: 20)
                ForEach(StockConvertViewModel.allCases, id: \.rawValue) {  item  in
                    VStack {
                        Text(item.description)
                            .spoqaHan(family: selectStock == item ? .Bold : .Medium, size: 15)
                            .foregroundColor(selectStock == item ? Color.white : Color.fontColor.mainFontColor)
                            .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                            .background(selectStock == item ? Color.colorAssets.skyblue4.opacity(0.8) : Color.clear)
                            .clipShape(Capsule())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    self.selectStock = item
                                }
                            }
                    }
                }
                Spacer()
            }
        }
        .bounce(false)
    }
    //MARK: - 주식 리스트 header
    @ViewBuilder
    private func stockListTitle() -> some View {
        HStack {
            Text("주식")
            
            Spacer()
            
            HStack(spacing: 10) {
                Text("가격")
                
                Button {
                    stockMostViewModel.reloadData()
                } label: {
                    Image(systemName: "goforward")
                        
                }
                .rotationEffect(Angle(degrees: stockMostViewModel.isLoading ? 360 : .zero),
                                anchor: .center)
            }
        }
        .spoqaHan(family: .Regular, size: 13)
        .foregroundColor(Color.colorAssets.textColor)
        .padding(.horizontal)
        
    }
    //MARK: - 주식 전환 탭
    @ViewBuilder
    private func stockConvertList() -> some View {
        if selectStock == .most {
            stockMostList()
        } else if selectStock == .increase {
            stockIncreaseList()
        } else if selectStock == .littleChange {
            stockSmallCapList()
        } else if selectStock == . largeChange{
            stockLargeCapList()
        }
    }
    //MARK: - 주식 인기순
    @ViewBuilder
    private func stockMostList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(Array(stockMostViewModel.stockData.enumerated()), id: \.offset ) { index , stock in
                    LazyVStack {
                        StockRowView(stock: stock)
                            .padding(.horizontal, 20)
                            .onAppear {
                                let count = stockMostViewModel.stockData.count
                                if count < stockMostViewModel.totalCount {
                                    if index == count - 5 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            stockMostViewModel.getStockMostData()
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
        .bounce(false)
        .padding(.init(top: 26, leading: .zero, bottom: 48, trailing: 10))
    }
    //MARK: - 주식 상승률
    @ViewBuilder
    private func stockIncreaseList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(Array(stockMostViewModel.stockData.enumerated()), id: \.offset ) { index , stock in
                    LazyVStack {
                        StockRowView(stock: stock)
                            .padding(.horizontal, 20)
                            .onAppear {
                                let count = stockMostViewModel.stockData.count
                                if count < stockMostViewModel.totalCount {
                                    if index == count - 5 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                            stockMostViewModel.getStockIncreaseCapData()
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
        .bounce(false)
        .padding(.init(top: 26, leading: .zero, bottom: 48, trailing: 10))
    }
    //MARK: - 주식 변화량이 적은순
    @ViewBuilder
    private func stockSmallCapList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(Array(stockMostViewModel.stockData.enumerated()), id: \.offset ) { index , stock in
                    LazyVStack {
                        StockRowView(stock: stock)
                            .padding(.horizontal, 20)
                            .onAppear {
                                let count = stockMostViewModel.stockData.count
                                if count < stockMostViewModel.totalCount {
                                    if index == count - 5 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                            stockMostViewModel.getStockSmallCapData()
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
        .bounce(false)
        .padding(.init(top: 26, leading: .zero, bottom: 48, trailing: 10))
    }
    //MARK: - 주식 변화량이 많은순
    @ViewBuilder
    private func stockLargeCapList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(Array(stockMostViewModel.stockData.enumerated()), id: \.offset ) { index , stock in
                    LazyVStack {
                        StockRowView(stock: stock)
                            .padding(.horizontal, 20)
                            .onAppear {
                                let count = stockMostViewModel.stockData.count
                                if count < stockMostViewModel.totalCount {
                                    if index == count - 5 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                            stockMostViewModel.getStockLargeCapData()
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
        .bounce(false)
        .padding(.init(top: 26, leading: .zero, bottom: 48, trailing: 10))
    }
    
}

struct StockMainView_Previews: PreviewProvider {
    static var previews: some View {
        StockMainView(stockMostViewModel: StockMostViewModel())
    }
}
