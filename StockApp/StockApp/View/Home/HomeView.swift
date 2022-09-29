//
//  HomeView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack (alignment: .leading){
                Color.colorAssets.backGroundColor
                
                VStack{
                    Text("홈 화면 ")
            
                    
                    
                    Spacer(minLength: .zero)
                }
            }
            .navigationBarHidden(true)
            .padding(.horizontal , 10)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
    }
}
