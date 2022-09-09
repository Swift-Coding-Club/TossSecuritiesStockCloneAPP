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
                    Image(systemName: "wonsign.circle")
                        .foregroundColor(ColorAsset.subColor)
                    Text("국내주식")
                }
                
                ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("해외주식")
                }

            ContentView()
                    .tabItem {
                    Image(systemName: "text.justify")
                    Text("전체")
                }
        }
        .accentColor(ColorAsset.mauvepurple)
        .onAppear(){
            UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().tintColor = UIColor(ColorAsset.subColor)
            UITabBar.appearance().unselectedItemTintColor = UIColor(ColorAsset.navy)
          
        }
    }
}



struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabVIew()
        
    }
}
