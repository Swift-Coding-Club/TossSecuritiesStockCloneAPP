//
//  MainTabVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI
import UIKit

struct MainTabVIew: View {
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @EnvironmentObject var coinModel: CoinViewModel
    @State var currentTab = "house"
    //MARK: - 커브 의 value
    @State var curveAxis: CGFloat = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if viewModel.userSession == nil {
            LoginView()
        } else  {
            //MARK: - 로그인 을 했으면  maintab view 로직을
            mainTabView()
                
        }
    }
    
    @ViewBuilder
    private func mainTabView() -> some View {
        VStack(spacing: .zero) {
            TabView(selection: $currentTab) {
                HomeView()
                    .environmentObject(coinModel)
                    .tag("house")
                
                StockMainView()
                    .tag("chart.bar")
                
                AddMainView()
                    .tag("plus.circle")
                
                CryptoMainView()
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
        }
        .background(Color.colorAssets.navy.opacity(0.7))
        .ignoresSafeArea(.container, edges: .top)
        .navigationBarHidden(false)
//        .accentColor(Color.colorAssets.skyblue2)
//        .onAppear(){
//            UITabBar.appearance().barTintColor = .white
//            UITabBar.appearance().tintColor = UIColor(Color.colorAssets.subColor)
//            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.colorAssets.subColor)
//        }
    }
    
    @ViewBuilder
    private func tabBarAnimation() -> some View {
        ForEach(["house", "chart.bar" , "plus.circle" , "dollarsign.circle" , "person"] , id: \.self) { image in
            
            GeometryReader  { proxy in
                
                Button {
                    withAnimation {
                        currentTab = image
                        curveAxis = proxy.frame(in: .global).midX
                        
                    }
                } label: {
                    
                    Image(systemName: "\(image)\(currentTab == image ? ".fill" : "")")
                        .spoqaHan(family: .Medium, size: 20)
                        .foregroundColor(Color.colorAssets.white)
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color.colorAssets.navy.opacity(0.7))
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

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabVIew()
            .environmentObject(dev.coinViewModel)
                .environmentObject(dev.signUpViewModel)
        }
    }
}
