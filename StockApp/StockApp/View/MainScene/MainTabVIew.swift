//
//  MainTabVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI

struct MainTabVIew: View {
    @State var tabIndex = TabBarKind.home
    var body: some View {
        TabView(selection: $tabIndex){
                ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                        .font(.custom(FontAsset.mediumFont, size: 20))
                }
                
                ContentView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("국내주식")
                }
                
                ContentView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("추가")
                }
            
                ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("코인")
                }

                ContentView()
                    .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                            .foregroundColor(Color.colorAssets.blue)
                }
        }
        .accentColor(Color.colorAssets.skyblue)
        .onAppear(){
            UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().tintColor = UIColor(Color.colorAssets.subColor)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.colorAssets.navy)
          
        }
    }
}

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabVIew()
        
    }
}
