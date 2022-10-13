//
//  ProfileMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct ProfileMainView: View {
    @Environment(\.dismiss)  private var dismiss
    var body: some View {
        VStack {
            Text("프로필 관련 페이지")
            
            Button (action: {
                dismiss()
            }, label: {
                Text("로그아웃")
            })
            
                .font(.title)
        }
    }
}

struct ProfileMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
    }
}
