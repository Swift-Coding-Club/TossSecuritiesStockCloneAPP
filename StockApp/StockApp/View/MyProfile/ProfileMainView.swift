//
//  ProfileMainView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/19.
//

import SwiftUI
import ExytePopupView

struct ProfileMainView: View {
    
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @EnvironmentObject var accountViewModel: AccountManageViewModel
    @StateObject var profileViewModel = ProfilViewModel()
    
    @State private var policyInformationButton: Bool = false
    @State private var developerListButton: Bool  = false
    @State private var personalInformationButton: Bool = false
    @State private var showAlertLogout: Bool = false
    @State private var sendEmailButton: Bool = false
    @State private var noticeButton: Bool = false
    @State private var profileEditButton: Bool = false
    @State private var  settingButton: Bool = false
  
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    Color.colorAssets.backGroundColor
                        .ignoresSafeArea()
                    
                    Group {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading) {
                                spacingHeight(height: 32)
                                
                                profileHeader(userName: accountViewModel.userName ?? "", email: accountViewModel.userEmail ?? "")
                                
                                spacingHeight(height: 40)
                                
                                editProfile()
                                
                                appInformationListButton()
                                
                                feedBackListButton()
                                
                                logoutListButton()
                                
                                appinformationEtcButton()
                                
                                Spacer(minLength: .zero)
                            }
                        }
                        .bounce(false)
                    }
                }
                .popup(isPresented: $showAlertLogout,  type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    PopupView()
                        .environmentObject(viewModel)
                }
                .popup(isPresented: $noticeButton, type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    ReadyPopUPview()
                }
                .popup(isPresented: $settingButton, type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    ReadyPopUPview()
                }
                .popup(isPresented: $sendEmailButton, type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    ReadyPopUPview()
                }
            }
            .onAppear {
                accountViewModel.getUserInformation()
            }
        } else {
            NavigationView {
                ZStack {
                    Color.colorAssets.backGroundColor
                        .ignoresSafeArea()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            spacingHeight(height: 32)
                            
                            profileHeader(userName: accountViewModel.userName ?? "Roy", email: accountViewModel.userEmail ?? "shuwj199@gmail.com")
                            
                            spacingHeight(height: 40)
                            
                            editProfile()
                            
                            appInformationListButton()
                            
                            feedBackListButton()
                            
                            logoutListButton()
                            
                            appinformationEtcButton()
                            
                            Spacer(minLength: .zero)
                        }
                    }
                    .bounce(false)
                }
                .popup(isPresented: $showAlertLogout,  type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    PopupView()
                        .environmentObject(viewModel)
                }
                .popup(isPresented: $noticeButton, type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    ReadyPopUPview()
                }
                .popup(isPresented: $settingButton, type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    ReadyPopUPview()
                }
                .popup(isPresented: $sendEmailButton, type: .default, position: .bottom, animation: .spring(), closeOnTap: true, closeOnTapOutside: true) {
                    ReadyPopUPview()
                }
            }
        }
    }
    //MARK: - 프로필 상단
    @ViewBuilder
    private func profileHeader(userName: String, email: String) -> some View {
        HStack {
            Circle()
                .frame(width: 72, height: 72)
            
            Spacer()
                .frame(width: 10)
            
            VStack(alignment: .leading , spacing: 5) {
                Text(userName)
                    .spoqaHan(family: .Bold, size: 18)
                Text(email)
            }
            Spacer()
        }
        .foregroundColor(Color.fontColor.mainFontColor)
        .padding(.horizontal, 30)
    }
    //MARK: - 스페이싱 높이
    @ViewBuilder
    private func spacingHeight(height: CGFloat) -> some View {
        Spacer()
            .frame(height: height)
    }
    //MARK: - 스페이싱 넓이
    @ViewBuilder
    private func spacingWidth(width: CGFloat) -> some View {
        Spacer()
            .frame(width: width)
    }
    //MARK: - 공지 사항 및  환경설정 뷰
    @ViewBuilder
    private func editProfile() -> some View {
        HStack(spacing: 20) {
            Spacer()
            ForEach(ProfileEditViewModel.allCases , id: \.rawValue) { item in
                if item == .notice {
                    Button {
                        noticeButton.toggle()
                    } label: {
                        ProfileEditView(image: item.imageName, title: item.description)
                        //                            .background(
                        //                                NavigationLink(destination: ProfileNotice(),
                        //                                               isActive: $noticeButton,
                        //                                               label: { EmptyView()})
                        //                            )
                    }
                    
                } else if item == .profileEdit {
                    Button {
                        profileEditButton.toggle()
                    } label: {
                        ProfileEditView(image: item.imageName, title: item.description)
                            .background(
                                NavigationLink(destination: MyProfileEditView(),
                                               isActive: $profileEditButton,
                                               label: { EmptyView()})
                            )
                    }
                    
                } else if item == .appSetting {
                    Button {
                        settingButton.toggle()
                    } label: {
                        ProfileEditView(image: item.imageName, title: item.description)
                        //                            .background(
                        //                                NavigationLink(destination: SettingView(),
                        //                                               isActive: $settingButton,
                        //                                               label: { EmptyView()})
                        //                            )
                    }
                }
            }
            Spacer()
        }
        spacingHeight(height: 30)
    }
    //MARK: - 앱 정보
    @ViewBuilder
    private func appInformationListButton()  -> some View {
        Section {
            ForEach(InformationVIewModel.allCases, id: \.rawValue) { item in
                if item == .termsOfService {
                    Button {
                        policyInformationButton.toggle()
                    } label: {
                        ListRowSystemImageTextView(title: item.description, imageName: item.imageName, width: 15,  height: 20)
                            .background(
                                NavigationLink(destination: TermsServiceView(),
                                               isActive: $policyInformationButton,
                                               label: {EmptyView()}))
                    }
                } else if item == .personalInformation {
                    Button {
                        personalInformationButton.toggle()
                    } label: {
                        ListRowTextView(title: item.description, imageName: item.imageName)
                            .background(
                                NavigationLink(destination: PersonalInformationView(),
                                               isActive: $personalInformationButton,
                                               label: {EmptyView()}))
                    }
                } else if item == .developer {
                    Button {
                        developerListButton.toggle()
                    } label: {
                        ListRowTextView(title: item.description, imageName: item.imageName)
                            .background(
                                NavigationLink(destination: DeveloperView(),
                                               isActive: $developerListButton,
                                               label: {EmptyView()}))
                    }
                }
            }
        } header: {
            Text("약관 및 정책")
                .spoqaHan(family: .Medium, size: 18)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
        .padding(.horizontal)
        spacingHeight(height: 30)
    }
    //MARK: - 피드백
    @ViewBuilder
    private func feedBackListButton() -> some View {
        Section{
            ForEach(FeedBackViewModel.allCases, id: \.rawValue) { item in
                if item == .sendEmail {
                    Button {
                        guard let url = URL(string: "mailto:shuwj81@daum.net") else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    } label: {
                        ListRowSystemImageTextView(title: item.description, imageName: item.imageName, width: 15,  height: 12)
                        //                            .background(
                        //                                NavigationLink(destination: DeveloperView(),
                        //                                               isActive: $sendEmailButton,
                        //                                               label: {EmptyView()})
                        //                            )
                    }
                }
            }
        } header : {
            Text("피드백")
                .spoqaHan(family: .Medium, size: 18)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
        .padding(.horizontal)
        spacingHeight(height: 30)
    }
    //MARK: - 앱 계정 관리
    @ViewBuilder
    private func logoutListButton() -> some View  {
        Section {
            ForEach(AppLogoutViewModel.allCases, id: \.rawValue) { item in
                if item == .logout {
                    Button {
                        showAlertLogout.toggle()
                    } label: {
                        ListRowSystemImageTextView(title: item.description, imageName: item.imageName, width: 15, height: 20)
                    }
                }
            }
        }header: {
            Text("계정 관리")
                .spoqaHan(family: .Medium, size: 18)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
        .padding(.horizontal)
        spacingHeight(height: 30)
    }
    //MARK: - 앱 정보 및  기타
    @ViewBuilder
    private func appinformationEtcButton() -> some View {
        Section {
            ForEach(ProfileInformationViewModel.allCases, id: \.rawValue) { item in
                if item == .appVersion {
                    ListAppRowView(title: item.description, appVersionTitle: profileViewModel.appVersion)
                }
            }
        } header: {
            Text("기타")
                .spoqaHan(family: .Medium, size: 18)
                .foregroundColor(Color.fontColor.mainFontColor)
        }
        .padding(.horizontal)
        spacingHeight(height: 30)
    }
}

struct ProfileMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
            .environmentObject(dev.signUpViewModel)
            .environmentObject(dev.accountViewModel)
    }
}
