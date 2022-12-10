//
//  DeveloperView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/20.
//

import SwiftUI

struct DeveloperView: View {
    
    var body: some View {
        
        VStack {
            NavigationView {
                
                
                VStack(alignment: .leading) {
                    
                    Spacer()
                        .frame(height: 15)
                    
                    developerTitle()
                    
                    developerRow()
                    
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                .navigationTitle(Text("개발자소개"))
            }
        }
        
    }
    
    @ViewBuilder
    private func developerTitle()  -> some View{
        VStack(spacing: .zero){
            Text("서비스를 개발한 개발자들을 소개합니다.")
                .spoqaHan(family: .Medium, size: 20)
                .foregroundColor(Color.fontColor.mainFontColor)
            Divider()
        }
    }
    
    @ViewBuilder
    private func developerRow() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(DevloperViewModel.allCases, id: \.rawValue) { item in
                if item == .roy {
                    DeveloperRowView(profileImage: item.profileImage, developerName: item.description, githubLinke: item.githublink, instagram: item.instagram, informationTitle: item.information)
                } else if item == .eric {
                    DeveloperRowView(profileImage: item.profileImage, developerName: item.description, githubLinke: item.githublink, instagram: item.instagram, informationTitle: item.information)
                } else if item == .lia {
                    DeveloperRowView(profileImage: item.profileImage, developerName: item.description, githubLinke: item.githublink, instagram: item.instagram, informationTitle: item.information)
                } else if item == .nadine {
                    DeveloperRowView(profileImage: item.profileImage, developerName: item.description, githubLinke: item.githublink, instagram: item.instagram, informationTitle: item.information)
                } else if item == .ruby {
                    DeveloperRowView(profileImage: item.profileImage, developerName: item.description, githubLinke: item.githublink, instagram: item.instagram, informationTitle: item.information)
                }
            }
        }
        .bounce(false)
    }
    
}


struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
