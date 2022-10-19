//
//  MainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack (alignment: .topLeading) {
            MainTabVIew()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            
    }
}
