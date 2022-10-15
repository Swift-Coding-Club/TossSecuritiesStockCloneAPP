//
//  ProfileMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct ProfileMainView: View {
    @Environment(\.dismiss)  private var dismiss
    @EnvironmentObject var viewModel: SignUpVIewModel
    
    var body: some View {
        VStack {
            
           topHeader()
            
            Text("프로필 관련 페이지")
            
            Button (action: {
                viewModel.signOut()
            }, label: {
                Text("로그아웃")
            })
                .font(.title)
            Spacer()
        }
    }
    //MARK: - 상단  배경
    @ViewBuilder
    private func topHeader() -> some View {
        ZStack(alignment: .top) {
            Color.colorAssets.blue3
        }
        .frame(height: (UIScreen.main.bounds.height / 3.5) - 30)
        .clipShape(RoundShape(corners: [.bottomRight]))
        .ignoresSafeArea()
    }
    @ViewBuilder
    private func profileImageView() -> some View {
        
    }
    
}

struct ProfileMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
            .environmentObject(dev.signUpViewModel)
    }
}
