//
//  StockSearchView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/29.
//

import SwiftUI
import XCAStocksAPI

@available(iOS 16.0, *)
struct StockSearchView: View {
    @EnvironmentObject var viewModel : StockViewModels
    @StateObject var stockQuoteViewModel = StockQuoteViewModel()
    @ObservedObject var searchViewModel: StockSearchViewModel
    
    var body: some View {
        List(searchViewModel.tickers) { ticker in
            TickerListRowView(
                data: .init(
                    symbol: ticker.symbol,
                    name: ticker.shortname ?? "",
                    price: stockQuoteViewModel.priceForTicker(ticker),
                    type: .search(
                        isSaved: viewModel.isAddedToMyTickers(ticker: ticker),
                        onButtonTapped: {  Task{viewModel.toggleTicker(ticker )} }
                    )
                )
            )
//            .contentShape(Rectangle())
//            .onTapGesture {
//               
//            }
        }
        .listStyle(.plain)
        .refreshable {
            await stockQuoteViewModel.fetchQuote(tickers: searchViewModel.tickers)
        }
        .task(id: searchViewModel.tickers) {
            await stockQuoteViewModel.fetchQuote(tickers: searchViewModel.tickers)}
        .overlay { listSearchOverlay() }
    }
    
    @ViewBuilder
    private func listSearchOverlay() -> some View {
        switch searchViewModel.phase {
        case .failuer(let error):
            ErrorStateView(error: error.localizedDescription) {
                Task { await searchViewModel.searchTicker()}
            }
        case .empty:
            EmptyStateView(text: searchViewModel.emptyListText)
        case .fetching:
            LoadingStateView()
        default:
            EmptyView()
        }
    }
}

struct StockSearchView_Previews: PreviewProvider {
    @StateObject static var stubbedSearchVM : StockSearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedSearchTickerCallback = { Ticker.stubs }
        let vm = StockSearchViewModel(searchStock: "Apple", stockAPI: mock)
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    @StateObject static var emptySearchVM : StockSearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedSearchTickerCallback = { [ ] }
        return StockSearchViewModel(searchStock: "thje", stockAPI: mock)
    }()
    
    @StateObject static var loadingSearchVM : StockSearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedSearchTickerCallback = {
            await withCheckedContinuation { _ in }
        }
        
        return StockSearchViewModel(searchStock: "Apple", stockAPI: mock)
    }()
    
    @StateObject static var errorSearchVM : StockSearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedSearchTickerCallback = { throw NSError(domain: "", code: .zero , userInfo: [NSLocalizedDescriptionKey: "검색 에러가 났어요 "])}
        return StockSearchViewModel(searchStock: "Apple", stockAPI: mock)
    }()
    
    @available(iOS 16.0, *)
    @StateObject static var stockVM: StockViewModels = {
        var mock = MockTickerListRepository()
        mock.stubbedLoad = { Array(Ticker.stubs.prefix(upTo: 2)) }
        return StockViewModels(repository: mock)
    }()
    
    static var quoteVM : StockQuoteViewModel = {
        var mock = MockStockAPI()
        mock.stubbedFetchQuoteCallBack =  { Quote.stubs }
        return  StockQuoteViewModel(stocksAPI: mock)
    }()
    
    static var previews: some View {
        if #available(iOS 16.0, *) {
            Group {
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        StockSearchView(stockQuoteViewModel: quoteVM, searchViewModel: stubbedSearchVM)
                    }
                    .searchable(text: $stubbedSearchVM.searchStock)
                    .previewDisplayName("Results")
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        StockSearchView(stockQuoteViewModel: quoteVM, searchViewModel: emptySearchVM)
                    }
                    .searchable(text: $emptySearchVM.searchStock)
                    .previewDisplayName("Empty Results")
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        StockSearchView(stockQuoteViewModel: quoteVM, searchViewModel: loadingSearchVM)
                    }
                    .searchable(text: $loadingSearchVM.searchStock)
                    .previewDisplayName("loading State")
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        StockSearchView(stockQuoteViewModel: quoteVM, searchViewModel: errorSearchVM)
                    }
                    .searchable(text: $errorSearchVM.searchStock)
                    .previewDisplayName("Error Results")
                } else {
                    
                }
                
            }
            .environmentObject(stockVM)
        } else {
            // Fallback on earlier versions
        }
    }
}
