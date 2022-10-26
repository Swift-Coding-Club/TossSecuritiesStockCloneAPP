//
//  Test.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/27.
//

import SwiftUI
import HidableTabView

struct Test: View {
    @State var selectedTab = "house"
    @ObservedObject private var tabViewManager = TabViewManager()
    var body: some View {
        ZStack(alignment: .bottom, content: {
            
            Color.colorAssets.subColor
                .ignoresSafeArea()
            
            VStack {
                TabView(selection: $selectedTab) {
                    ProfileMainView()
                        .tag("home")
                    ProfileMainView()
                        .tag("bookmark")
                    ProfileMainView()
                        .tag("message")
                    ProfileMainView()
                        .tag("person")
                }
                CustomTabBar(selectedTab: $selectedTab)
            }
            // Custom Tab Bar....
            
           
        })
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
        
    }
}
