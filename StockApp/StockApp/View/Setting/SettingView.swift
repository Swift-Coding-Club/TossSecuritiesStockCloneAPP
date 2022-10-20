//
//  SettingView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/16.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            VStack {
                Spacer()
                    .frame(height: 10)
                
                settingHeader()
                
                Spacer()
                    .frame(height: 10)
                
                List {
                    //MARK: - 로그아웃 리스트
                    logoutListButton()
                    
                    appInformationListButton()
                          
                }
                .listStyle(PlainListStyle())
                
                Spacer(minLength: .zero)
                
            }
            .navigationTitle("")
            .spoqaHan(family: .Medium, size: 10)
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    //MARK: - 설정 화면 상단
    @ViewBuilder
    private func settingHeader() -> some View {
        HStack {
            Text("코인 모여 설정 화면 ")
                .spoqaHan(family: .Bold, size: 25)
                .foregroundColor(Color.fontColor.mainFontColor)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    //MARK: - 로그아웃 버튼
    @ViewBuilder
    private func logoutListButton() -> some View  {
        Section {
            ForEach(AppLogoutViewModel.allCases, id: \.rawValue) { item in
                if item == .logout {
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack{
                            Image(systemName: item.imageName)
                                .resizable()
                                .frame(width: 15, height: 15)
                            
                            Spacer()
                                .frame(width: 10)
                            
                            Text(item.description)
                                .spoqaHan(family: .Medium, size: 20)
                                .foregroundColor(Color.fontColor.mainFontColor)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 10, height: 15)
                                .foregroundColor(Color.fontColor.mainFontColor)
                        }
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func appInformationListButton()  -> some View {
        Section {
            ForEach(InformationVIewModel.allCases, id: \.rawValue) { item in
                if item == .developer {
                    NavigationLink {
                        DeveloperView()
                    } label: {
                        HStack{
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.fontColor.mainFontColor)
                            
                            Spacer()
                                .frame(width: 10)
                            
                            Text(item.description)
                                .spoqaHan(family: .Medium, size: 20)
                                .foregroundColor(Color.fontColor.mainFontColor)
                        }
                    }
                }
            }
        } header: {
            Text("코인 모여 앱 정보")
                .spoqaHan(family: .Medium, size: 15)
                .foregroundColor(Color.fontColor.sideMenuColor)
        }
        
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
                .environmentObject(dev.signUpViewModel)
        }
    }
}
