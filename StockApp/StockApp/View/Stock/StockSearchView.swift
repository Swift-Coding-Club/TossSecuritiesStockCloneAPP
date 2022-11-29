//
//  StockSearchView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/29.
//

import SwiftUI
import XCAStocksAPI

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
                        onButtonTapped: {  viewModel.toggleTicker(ticker ) }
                    )
                )
            )
            .contentShape(Rectangle())
            .onTapGesture { }
        }
        .listStyle(.plain)
        .overlay { listSearchOverlay() }
    }
    
    @ViewBuilder
    private func listSearchOverlay() -> some View {
        switch searchViewModel.phase {
        case .failuer(let error):
            ErrorStateView(error: error.localizedDescription) { }
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
        let vm = StockSearchViewModel()
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    @StateObject static var emptySearchVM : StockSearchViewModel = {
        let vm = StockSearchViewModel()
        vm.searchStock = "Theranos"
        vm.phase = .empty
        return vm
    }()
    
    @StateObject static var loadingSearchVM : StockSearchViewModel = {
        let vm = StockSearchViewModel()
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    @StateObject static var errorSearchVM : StockSearchViewModel = {
        let vm = StockSearchViewModel()
        vm.phase = .failuer(NSError(domain: "", code: .zero , userInfo: [NSLocalizedDescriptionKey: "검색 에러가 났어요 "]))
        return vm
    }()
    
    @StateObject static var stockVM: StockViewModels = {
        let vm = StockViewModels()
        vm.tickers = Array(Ticker.stubs.prefix(upTo: 2))
        return vm
    }()
    
    static var quoteVM : StockQuoteViewModel = {
        let vm  = StockQuoteViewModel()
        vm.quotesDict = Quote.subsDict
        return vm
    }()
    
    static var previews: some View {
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
                // Fallback on earlier versions
            }
            
    
        }
        .environmentObject(stockVM)
    }
}
