//
//  SettingView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/16.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
    
            VStack {
                Text("앱 설정 화면 ")
                     .font(.custom(FontAsset.mediumFont, size: 30))
                
                Spacer(minLength: .zero)
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
}
