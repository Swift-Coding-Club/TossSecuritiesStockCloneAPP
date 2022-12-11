//
//  MainTabVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI
import UIKit

@available(iOS 16.0, *)
struct MainTabVIew: View {
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @EnvironmentObject var coinViewModel: CoinViewModel
    @EnvironmentObject var stockViewModel: StockViewModels
    @EnvironmentObject var stockIntersetViewModel: StockViewModel
    
    @State var currentTab = "house"
    @State var curveAxis: CGFloat = 0
    
    private let user: DevloperPreview = DevloperPreview()
    //MARK: - 커브 의 value
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if viewModel.userSession == nil {
            LoginMainView()
        } else  {
            //MARK: - 로그인 을 했으면  maintab view 로직을
            mainTabView()
                
        }
    }
    
    @ViewBuilder
    private func mainTabView() -> some View {
        VStack(spacing: .zero) {
            TabView(selection: $currentTab) {
                HomeView(stockViewModel: StockViewModel())
                    .environmentObject(coinViewModel)
                    .tag("house")
                
                StockMainView(searchViewModel: StockSearchViewModel())
                    .environmentObject(stockViewModel)
                    .environmentObject(stockIntersetViewModel)
                    .tag("chart.bar")
                
//                AddMainView()
//                    .tag("plus.circle")
                
                CryptoMainView(showView: .constant(false))
                    .tag("dollarsign.circle")
                
                ProfileMainView()
                    .tag("person")
            }
            .clipShape(
                CustomTabCurve(curveAxis: curveAxis)
            )
            .padding(.bottom , -90)
            
            HStack(spacing: .zero) {
                tabBarAnimation()
            }
            .frame(height: 50)
            .padding(.horizontal , 35)
            .padding(.bottom,getSafeArea().bottom == 0 ? 10 : 0)
        }
        .background(Color.colorAssets.navy2)
        .ignoresSafeArea(.container, edges: .top)
        .navigationBarHidden(false)

    }
    
    @ViewBuilder
    private func tabBarAnimation() -> some View {
//        "plus.circle" ,
        ForEach(["house", "chart.bar" ,  "dollarsign.circle" , "person"] , id: \.self) { image in
            
            GeometryReader  { proxy in
                
                Button {
                    withAnimation {
                        currentTab = image
                        curveAxis = proxy.frame(in: .global).midX
                        
                    }
                } label: {
                    
                    Image(systemName: "\(image)\(currentTab == image ? ".fill" : "")")
                        .spoqaHan(family: .Bold, size: 20)
                        .foregroundColor(Color.colorAssets.white)
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color.colorAssets.navy2)
                        )
                    
                        .offset(y: currentTab == image ? -25 : .zero )
                    
                }
                .frame(maxWidth: .infinity , alignment: .center)
                .onAppear{
                    if curveAxis == .zero && image == "house" {
                        curveAxis =  proxy.frame(in: .global).midX
                    }
                }
                
            }
            .frame(height: 30)
        }
    }
}

@available(iOS 16.0, *)
struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainTabVIew()
                .environmentObject(dev.coinViewModel)
                .environmentObject(dev.signUpViewModel)
        }
    }
}
