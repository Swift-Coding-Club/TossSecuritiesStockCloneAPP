//
//  UserStatusView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/19.
//

import SwiftUI

struct UserStatusView: View {
    var body: some View {
        HStack(spacing: 24) {
           follower()
            
            following()
            
        }
      
    }
    @ViewBuilder
    private func follower() -> some View {
        HStack(spacing: 4) {
            Text("807")
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(Color.fontColor.sideMenuColor)
            
            Text("팔로워")
                .spoqaHan(family: .Regular, size: 15)
                .foregroundColor(Color.fontColor.sideMenuColor)
        }
    }
    
    @ViewBuilder
    private func following()  -> some View {
        HStack(spacing: 4) {
            Text("6.9M")
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(Color.fontColor.sideMenuColor)
            
            Text("팔로윙")
                .spoqaHan(family: .Regular, size: 15)
                .foregroundColor(Color.fontColor.sideMenuColor)
        }
    }
}

struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView()
    }
}
