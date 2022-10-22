//
//  TweetRowVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/17.
//

import SwiftUI

struct TweetRowVIew: View {
    var body: some View {
        
        VStack (alignment: .leading){
            HStack (alignment: .top, spacing: 12) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(Color.colorAssets.blue3)
                //MARK: - user info tweet
                userNameInfo()
                
            }
            messagingButton()
        }
    }
    //MARK: - user info
    
    @ViewBuilder
    private func userNameInfo() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Roy")
                    .spoqaHan(family: .Bold, size: 20)
                
                Text("@Roy")
                    .foregroundColor(Color.gray)
                    .spoqaHan(family: .Medium, size: 15)
                
                Text("2w")
                    .foregroundColor(Color.gray)
                    .spoqaHan(family: .Medium, size: 15)
            }
            
            Text("IOS Developer roy")
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
        }
        
    }
    
    @ViewBuilder
    private func messagingButton() -> some View {
        HStack {
            
            Button {
                
            } label: {
                Image(systemName: "bubble.left")
                    .spoqaHan(family: .Regular, size: 18)
            }
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.2.squarepath")
                    .spoqaHan(family: .Regular, size: 18)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "heart")
                    .spoqaHan(family: .Regular, size: 18)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bookmark")
                    .spoqaHan(family: .Regular, size: 18)
            }
            .padding()
            
            
        }
        .foregroundColor(.gray)
        Divider()
    }
}

struct TweetRowVIew_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowVIew()
    }
}
