//
//  FeedView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/17.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            ScrollView {
                ForEach(0...10, id: \.self) { _ in
                    TweetRowVIew()
                        .padding()
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
