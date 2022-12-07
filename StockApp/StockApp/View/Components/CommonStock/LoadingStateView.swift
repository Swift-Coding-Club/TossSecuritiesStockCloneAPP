//
//  LoadingStateView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
    }
}

struct LoadingStateView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingStateView()
    }
}
