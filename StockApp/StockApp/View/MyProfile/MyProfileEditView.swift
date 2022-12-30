//
//  MyProfileEditView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/15.
//

import SwiftUI

// MARK: - 프로필 수정 뷰
struct MyProfileEditView: View {
    
    @EnvironmentObject var accountViewModel: AccountManageViewModel
    @EnvironmentObject var authViewModel: AuthorizationVIewModel
    
    @State private var name: String = ""
    @State private var nickName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            
            ScrollView(){
                Spacer()
                    .frame(height: 10)
                
                imageEditView()
                    .padding()
                
                Divider()
                    .padding()
                
                VStack(spacing: 20) {
                    nameEditView()
                    nickNameEditView()
                    phoneNumberEditView()
                    emailView()
                    Spacer()
                    saveButton()
                }
                .onAppear() {
                    name = accountViewModel.userName ?? ""
                    nickName = accountViewModel.userNickName ?? ""
                    phoneNumber = accountViewModel.userPhoneNumber ?? ""
                    email = accountViewModel.userEmail ?? ""
                }
            }
        }
    }
    
    // MARK: - @ViewBuilders
    @ViewBuilder
    private func imageEditView() -> some View {
        VStack(spacing: 20) {
            ZStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let profileImage = profileImage {
                        ZStack {
                            profileImage
                                .resizable()
                                .renderingMode(.original)
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                            Image(systemName: "square.and.pencil")
                                .modifier(EditImageModifier())
                        }
                    } else {
                        if accountViewModel.userImage == nil {
                            ZStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .renderingMode(.original)
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                Image(systemName: "square.and.pencil")
                                    .modifier(EditImageModifier())
                            }
                        } else {
                            ZStack {
                                Image(uiImage: accountViewModel.userImage!)
                                    .resizable()
                                    .renderingMode(.original)
                                    .scaledToFill()
                                    .clipShape(Circle())
                                Image(systemName: "square.and.pencil")
                                    .modifier(EditImageModifier())
                            }
                            .frame(width: 120 , height: 120)
                            
                        }
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }
        }
    }
    
    @ViewBuilder
    private func nameEditView() -> some View {
        CustomInputField(imageName: "", placeHolderText: "이름", text: $name)
    }
    
    @ViewBuilder
    private func nickNameEditView() -> some View {
        CustomInputField(imageName: "", placeHolderText: "닉네임", text: $nickName)
    }
    
    @ViewBuilder
    private func phoneNumberEditView() -> some View {
        CustomInputField(imageName: "", placeHolderText: "전화번호", text: $phoneNumber)
    }
    
    @ViewBuilder
    private func emailView() -> some View {
        CustomDisabledInputField(imageName: "", placeHolderText: "이메일", text: $email)
    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            accountViewModel.saveUserInformation(name: name, nickName: nickName, phoneNumber: phoneNumber)
            if let selectedImage = selectedImage {
                accountViewModel.userImage = selectedImage
                accountViewModel.saveProfileImage(selectedImage)
            }
        } label : {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Navy2"))
                    .frame(width: 200, height: 44)
                Text("SAVE")
                    .foregroundColor(Color("White"))
                    .font(.spoqaHan(family: .Medium, size: 20))
            }
        }
    }
    
    // MARK: - 일반함수
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

private struct EditImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .background(.white)
            .cornerRadius(10, corners: .allCorners)
            .offset(x: 40, y: 40)
    }
}

struct MyProfileEditView_Previews: PreviewProvider {
    static let accountView = AccountManageViewModel()
    
    static var previews: some View {
        MyProfileEditView()
            .environmentObject(dev.signUpViewModel)
            .environmentObject(accountView)
    }
}
