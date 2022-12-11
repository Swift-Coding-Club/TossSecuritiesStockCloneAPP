//
//  DeveloperRowView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/11.
//

import SwiftUI

struct DeveloperRowView: View {
    
    let profileImage: String
    let developerName: String
    let githubLinke: String
    let instagram : String
    let informationTitle: String
    
    
    var body: some View {
        VStack{
            HStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: (UIScreen.main.bounds.width - 40), height: 200)
                    .foregroundColor(Color.colorAssets.backGroundColor)
                    .padding(.horizontal)
                    .foregroundColor(Color.colorAssets.backGroundColor)
                    .shadow(color: Color.fontColor.accentColor.opacity(0.15), radius: 20, x: 10, y: .zero)
                    .overlay {
                        HStack{
                            Image(profileImage)
                                .resizable()
                                .frame(width: 150 , height: 150)
                                .aspectRatio(contentMode: .fill)
                            
                            Spacer()
                                .frame(width: 20)
                            
                            VStack (alignment: .leading){
                                Text(developerName)
                                    .spoqaHan(family: .Bold, size: 20)
                                
                                Spacer()
                                    .frame(height: 10)
                                
                                HStack(spacing: 10) {
                                    NavigationLink {
                                        WebView(urlToLoad: githubLinke)
                                    } label: {
                                        Image("githhub")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .spoqaHan(family: .Regular, size: 15)
                                            .padding(.bottom, 10)
                                    }

                                    NavigationLink {
                                        WebView(urlToLoad: instagram)
                                    } label: {
                                        Image("인스타")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .spoqaHan(family: .Regular, size: 15)
                                            .padding(.bottom, 10)
                                    }

                                    
                                }
                                
                                
                                Text(informationTitle)
                                    .spoqaHan(family: .Regular, size: 15)
                                
                            }
                            .foregroundColor(Color.fontColor.mainFontColor)
                            
                            
                            Spacer()
                        }
                    }
                    .border(.background, width: 1)
            }
        }
    }
}

struct DeveloperRowView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperRowView(profileImage: "로이", developerName: "로이", githubLinke: "https://github.com/Roy-wonji", instagram: "https://www.instagram.com/iosdev.roy/", informationTitle: "안녕하세요")
    }
}
