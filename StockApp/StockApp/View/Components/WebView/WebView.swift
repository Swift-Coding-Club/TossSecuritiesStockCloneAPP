//
//  WebView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    //MARK: - 링크할 url
    var urlToLoad: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlToLoad: "https://velog.io/@suhwj/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EC%B2%98%EB%A6%AC-%EB%B0%A9%EC%B9%A8")
    }
}
