//
//  StockMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI
import XCAStocksAPI

struct StockMainView: View {
    @Namespace var animation
    @State var selectStock : StockConvertViewModel = .myInterestMarket
    @EnvironmentObject var viewModel : StockViewModels
    @EnvironmentObject var stockIntersetViewModel: StockViewModel
    @StateObject var stockQuoteViewModel = StockQuoteViewModel()
    @StateObject var searchViewModel: StockSearchViewModel
    
    private let stockSearchPlaceholder: String = "검색할 주식을 입력해주세요..."
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            if #available(iOS 16.0, *) {
                if selectStock == .myInterestMarket {
                    NavigationStack {
                        VStack(spacing: .zero) {
                            Spacer().frame(height: 20)
                            
                            convertTitle()
                                .padding(.bottom , 10)
                            
                            //MARK: - 주식 검색
                            SearchBarView(searchBarTextField: $searchViewModel.searchStock, placeholder: stockSearchPlaceholder)
                                .refreshable {
                                    await stockQuoteViewModel.fetchQuote(tickers: viewModel.tickers)
                                }
                                .task(id: viewModel.tickers) {
                                    await stockQuoteViewModel.fetchQuote(tickers: viewModel.tickers)
                                }
                            stockListTitle()
                            
                            stockConvertList()
                                .padding(.bottom, 12)
                                .padding(.vertical , 30)
                            
                            Spacer(minLength: .zero)
                        }
                        .toolbar {
                            titleToolbar
                        }
                    }
                } else {
                    NavigationStack {
                        VStack(spacing: .zero) {
                            Spacer().frame(height: 20)
                            
                            convertTitle()
                                .padding(.bottom , 10)
                            
                            stockListTitle()
                            ScrollView(.vertical , showsIndicators: false) {
                                
                                stockConvertList()
                                    .padding(.bottom, 12)
                            }
                            .bounce(false)
                            .padding(.vertical , 30)
                            
                            Spacer(minLength: .zero)
                        }
                        .toolbar {
                            titleToolbar
                        }
                    }
                }
                
            } else {
                if selectStock == .myInterestMarket {
                    NavigationView {
                        VStack(spacing: .zero) {
                            Spacer().frame(height: 20)
                              
                            convertTitle()
                                .padding(.bottom , 10)
                            
                            //MARK: - 주식 검색
                                .refreshable {
                                    await stockQuoteViewModel.fetchQuote(tickers: viewModel.tickers)
                                }
                            SearchBarView(searchBarTextField: $searchViewModel.searchStock, placeholder: stockSearchPlaceholder)
                                  .refreshable {
                                    await stockQuoteViewModel.fetchQuote(tickers: viewModel.tickers)
                                }
                                .task(id: viewModel.tickers) {
                                    await stockQuoteViewModel.fetchQuote(tickers: viewModel.tickers)
                                }
                                .padding(.bottom, 5)
                            stockListTitle()
                            
                            stockListTitle()
                            
                            stockConvertList()
                                .padding(.bottom, 12)
                                .padding(.vertical , 30)
                            
                            Spacer(minLength: .zero)
                        }
                        .toolbar {
                            titleToolbar
                        }
                    }
                } else {
                    NavigationView {
                        VStack(spacing: .zero) {
                            Spacer().frame(height: 20)
                            
                            convertTitle()
                                .padding(.bottom , 10)
                            
                            //MARK: - 주식 검색
                            
                            stockListTitle()
                            ScrollView(.vertical , showsIndicators: false) {
                                
                                stockConvertList()
                                    .padding(.bottom, 12)
                            }
                            .bounce(false)
                            .padding(.vertical , 30)
                            
                            Spacer(minLength: .zero)
                        }
                        .toolbar {
                            titleToolbar
                        }
                    }
                }
                
            }
            
        }
    }
    
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
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        self.selectStock = item
                                    }
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
                    stockIntersetViewModel.reloadData()
                } label: {
                    Image(systemName: "goforward")
                }
                .rotationEffect(Angle(degrees: stockIntersetViewModel.isLoading ? 360 : .zero), anchor: .center)
            }
        }
        .spoqaHan(family: .Regular, size: 13)
        .foregroundColor(Color.colorAssets.textColor)
        .padding(.horizontal)
        
    }
    @ViewBuilder
    private func stockTickerList() -> some View {
        List{
            ForEach(viewModel.tickers) { stocks in
                TickerListRowView(
                    data: .init(
                        symbol: stocks.symbol,
                        name: stocks.shortname,
                        price: stockQuoteViewModel.priceForTicker(stocks),
                        type: .main))
                    .contentShape(Rectangle())
                    .padding(.horizontal)
                    .onTapGesture { }
            }
            .onDelete { viewModel.removeTickers(atOffsets: $0) }
            
        }
        .opacity(searchViewModel.isSearching ? .zero : 1)
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private func overlayView() -> some View {
        if viewModel.tickers.isEmpty {
            EmptyStateView(text: viewModel.emptyTickersText)
        }
        if searchViewModel.isSearching {
            StockSearchView(searchViewModel: searchViewModel)
            
        }
    }
    
    //MARK: - 네비게이션 바
    private var titleToolbar:  some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            VStack(alignment: .leading, spacing: -4){
                Spacer()
                Text(viewModel.titleText)
                Spacer()
                Text(viewModel.subTitleText)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            .spoqaHan(family: .Bold, size: 25)
            .padding(.bottom)
        }
    }
    
    //MARK: - 주식 전환 탭
    @ViewBuilder
    private func stockConvertList() -> some View {
        if selectStock == .myInterestMarket {
            stockTickerList()
                .overlay { overlayView() }
        } else if selectStock == .nsdMarketCap {
            StockRowList(stockViewModel: stockIntersetViewModel)
        } else if selectStock == .newYorkStock {
            StockNewYorkRowList(stockViewModel: stockIntersetViewModel)
        }
    }
}

struct StockMainView_Previews: PreviewProvider {
    @StateObject static var stockVM: StockViewModels =  {
        let vm = StockViewModels()
        vm.tickers = Ticker.stubs
        return vm
    }()
    
    @StateObject static var emptyVM: StockViewModels =  {
        let vm = StockViewModels()
        vm.tickers = []
        return vm
    }()
    
    static var quoteVM: StockQuoteViewModel =  {
        let vm = StockQuoteViewModel()
        vm.quotesDict = Quote.subsDict
        return vm
    }()
    
    static var searchVM: StockSearchViewModel =  {
        let vm = StockSearchViewModel()
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    static var previews: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    StockMainView(stockQuoteViewModel: quoteVM, searchViewModel: searchVM)
                    
                }
            } else {
                NavigationView {
                    StockMainView(stockQuoteViewModel: quoteVM, searchViewModel: searchVM)
                    
                }
            }
            if #available(iOS 16.0, *) {
                NavigationStack {
                    StockMainView(stockQuoteViewModel: quoteVM, searchViewModel: searchVM)
                    
                }
            } else {
                NavigationView {
                    StockMainView(stockQuoteViewModel: quoteVM, searchViewModel: searchVM)
                }
            }
        }
        .environmentObject(stockVM)
        .environmentObject(StockViewModel())
    }
}
