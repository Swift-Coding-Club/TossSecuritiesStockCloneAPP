//
//  TermsServiceView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import SwiftUI
import Introspect
import HidableTabView

struct TermsServiceView: View {
    private var personalInformationUrl: String = "https://velog.io/@suhwj/%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%80"
    
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

struct TermsServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsServiceView()
    }
}
