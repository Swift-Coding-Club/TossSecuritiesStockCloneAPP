//
//  SettingView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/16.
//

import SwiftUI
import Introspect
import ExytePopupView
import HidableTabView

struct SettingView: View {
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    
    @State private var developerListButton: Bool  = false
    @State private var personalInformationButton: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
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
                .popup(isPresented: $showAlert,  type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    PopupView()
                        .environmentObject(viewModel)
            
                }
            }
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
                        showAlert.toggle()
                    } label: {
                        ListRowSystemImageTextView(title: item.description, imageName: item.imageName)
                    }
                }
            }
        }header: {
            Text("나의 계정 설정")
                .spoqaHan(family: .Bold, size: 18)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
    }
    //MARK: - 앱 정보
    @ViewBuilder
    private func appInformationListButton()  -> some View {
        Section {
            ForEach(InformationVIewModel.allCases, id: \.rawValue) { item in
                if item == .developer {
                    Button {
                        developerListButton.toggle()
                    } label: {
                        ListRowTextView(title: item.description, imageName: item.imageName)
                            .background(
                                NavigationLink(destination:
                                                DeveloperView(),
                                               isActive: $developerListButton,
                                               label: {EmptyView()}))
                    }
                    
                } else if item == .personalInformation {
                    Button {
                        personalInformationButton.toggle()
                    } label: {
                        ListRowTextView(title: item.description, imageName: item.imageName)
                            .background(
                                NavigationLink(destination:
                                               PersonalInformationView(),
                                               isActive: $personalInformationButton,
                                               label: {EmptyView()})
                                )
                    }
                }
            }
        } header: {
            Text("코인 모여 앱 정보")
                .spoqaHan(family: .Bold, size: 18)
                .foregroundColor(Color.fontColor.mainFontColor)
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
