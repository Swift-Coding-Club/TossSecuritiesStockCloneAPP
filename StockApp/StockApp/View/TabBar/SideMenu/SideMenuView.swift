//
//  SideMenuView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/19.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(Color.colorAssets.blue3)
                
                profileHeader()
                
                UserStatusView()
                    .padding(.vertical)
            }
            .padding(.leading)
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue) { option in
                HStack(spacing: 16) {
                    Image(systemName: option.imageName)
                        .spoqaHan(family: .Medium, size: 20)
                        .foregroundColor(Color.fontColor.sideMenuColor)
                    Text(option.description)
                        .spoqaHan(family: .Regular, size: 20)
                        .foregroundColor(Color.fontColor.sideMenuColor)
                    
                    Spacer()
                }
                .frame(height: 40)
                .padding(.horizontal)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func profileHeader() -> some View {
        VStack(alignment: .leading , spacing: 4) {
            Text("IOS Developer Roy")
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(Color.fontColor.sideMenuColor)
            
            Text("@Roy")
                .spoqaHan(family: .Regular, size: 15)
                .foregroundColor(Color.fontColor.sideMenuColor)
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
