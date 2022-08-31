//
//  ContentView.swift
//  StockApp
//
//  Created by 서원지 on 2022/08/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Text("안녕하세요")
            .font(.custom(FontAsset.regularFont, size: 50))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
