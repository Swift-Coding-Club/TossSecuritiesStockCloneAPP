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
    
    var body: some View {
        if viewModel.userSession == nil {
            LoginView()
        } else  {
            //MARK: - 로그인 을 했으면  maintab view  로직을
            mainTabView()
        }
    }
    
    @ViewBuilder
    private func mainTabView() -> some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                        .font(.custom(FontAsset.mediumFont, size: 20))
                }
            
            StockMainView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("국내주식")
                }
            
            AddMainView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("추가")
                }
            
            CryptoMainView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("코인")
                }
            
            ProfileMainView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                        .foregroundColor(Color.colorAssets.blue)
                }
        }
        .navigationBarHidden(true)
        .accentColor(Color.colorAssets.skyblue2)
        .onAppear(){
            UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().tintColor = UIColor(Color.colorAssets.subColor)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.colorAssets.subColor)
        }
    }
}

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabVIew()
//            .environmentObject(dev.coinViewModel)
            .environmentObject(dev.signUpViewModel)
    }
}
