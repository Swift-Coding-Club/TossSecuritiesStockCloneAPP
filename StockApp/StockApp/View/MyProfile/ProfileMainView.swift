//
//  ProfileMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI

struct ProfileMainView: View {
    @Environment(\.dismiss)  private var dismiss
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                topHeader()
                
                editProfileButton()
                
                userInfoDetail()
                
                tweetFilterBar()
               
                
                 Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    navigationTrallingItem()
                }
            }
        }
    }
    //MARK: - 네비게이션 오른쪽 버튼
    @ViewBuilder
    private func navigationTrallingItem() -> some View {
        HStack {
            NavigationLink {
                FeedView()
            } label: {
                Image(systemName: "message.fill")
                    .resizable()
                    .foregroundColor(Color.colorAssets.white)
            }
            
            Spacer()
                .frame(width: 10)
            
            NavigationLink {
                SettingView()
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .foregroundColor(Color.colorAssets.white)
            }
        }
    }
   
    //MARK: - 상단  배경
    @ViewBuilder
    private func topHeader() -> some View {
        ZStack(alignment: .bottomLeading) {
            Color.colorAssets.blue3
                .clipShape(RoundShape(corners: [.bottomRight]))
                .ignoresSafeArea()
            
            VStack {
                
                Circle()
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
            }
        }
        .frame(height: (UIScreen.main.bounds.height / 6) - 30)
    }
    //MARK: - 프로필 수정 버튼
    @ViewBuilder
    private func editProfileButton() -> some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .spoqaHan(family: .Medium, size: 20)
                .padding(6)
                .overlay (
                    Circle()
                    .stroke(Color.gray, lineWidth: 0.75))
            
            Button {
                
            } label: {
                Text("프로필 수정")
                    .font(.custom(FontAsset.mediumFont, size: 20))
                    .bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(Color.fontColor.mainFontColor)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.75)
                    )
            }
        }
        .padding(.trailing)
    }
    //MARK: - 유정 정보
    @ViewBuilder
    private func userInfoDetail() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack  {
                Text("로이")
                    .spoqaHan(family: .Bold, size: 25)
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color.colorAssets.blue3)
            }
            
            Text("@로이2")
                .font(.subheadline)
                .foregroundColor(Color.gray)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("판교역")
                    
                }
                
                HStack {
                    Image(systemName: "link")
                    
                    Text("suhwj81@gmail.com")
                }
            }
            .font(.custom(FontAsset.regularFont, size: 13))
            .foregroundColor(.gray)
            
            HStack(spacing: 24) {
                HStack(spacing: 4) {
                    Text("807")
                        .font(.custom(FontAsset.mediumFont, size: 18))
                        .bold()
                    
                    Text("팔로윙")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
                
                HStack(spacing: 4) {
                    Text("6.99")
                        .font(.custom(FontAsset.mediumFont, size: 18))
                        .bold()
                    
                    Text("팔로워")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
            }
            .padding(.vertical)
           
        }
        .padding(.horizontal)
    }
    //MARK: - 상단 투윗 일반 좋아요 한부분 header
    @ViewBuilder
    private func tweetFilterBar() -> some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item  in
                VStack {
                    
                    Text(item.description)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color.fontColor.mainFontColor : .gray)
                    
                    if selectedFilter == item {
                       Capsule()
                            .foregroundColor(Color.colorAssets.blue3)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                             .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(
            Divider()
                .offset(x: .zero, y: 16)
        )
    }

}

struct ProfileMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
            .environmentObject(dev.signUpViewModel)
    }
}
