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
        TabView(selection: $tabIndex, content: {
            ContentView().tabItem {
                VStack{
                    Image(systemName: "house")
                        Text("홈")
                        .font(.custom(FontAsset.mediumFont, size: 20))
                }
            }
            
            ContentView().tabItem {
                VStack{
                    Image(systemName: "wonsign.circle")
                        .foregroundColor(ColorAsset.subColor)
                    Text("국내주식")
                }
            }
            
            ContentView().tabItem {
                VStack{
                    Image(systemName: "dollarsign.circle")
                    Text("해외주식")
                }
            }
            
            ContentView().tabItem {
                VStack{
                    Image(systemName: "text.justify")
                    Text("전체")
                }
                .onAppear(){
                    UITabBar.appearance().barTintColor = .gray
                }
            }
        })
        .accentColor(ColorAsset.subColor)
        .onAppear(){
            UITabBar.appearance().barTintColor = .gray
        }
    }
}

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabVIew()
    }
}
