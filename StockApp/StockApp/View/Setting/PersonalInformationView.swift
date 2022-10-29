//
//  PersonalInformationView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/22.
//

import SwiftUI
import HidableTabView

struct PersonalInformationView: View {
    
    private var personalInformationUrl: String = "https://velog.io/@suhwj/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EC%B2%98%EB%A6%AC-%EB%B0%A9%EC%B9%A8"
    
    @State var uiTabarController: UITabBarController?
    
    init() {
        UITabBar.hideTabBar(animated: false)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
           WebView(urlToLoad: personalInformationUrl)
        }
        .ignoresSafeArea()
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
                uiTabarController = UITabBarController
            }.onDisappear{
                uiTabarController?.tabBar.isHidden = false
            }
    }
}

struct PersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationView()
    }
}
