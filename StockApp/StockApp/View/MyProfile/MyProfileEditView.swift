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
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                Spacer()
                    .frame(height: 10)
                
                imageEditView()
                
                Divider()
                
                VStack(spacing: 20) {
                    
                    nameEditView()
                    phoneNumberEditView()
                    emailView()
                }
                .task {
                    name = accountViewModel.userName ?? ""
                    phoneNumber = accountViewModel.userPhoneNumber ?? ""
                    email = authViewModel.userSession?.email ?? ""
                }
                
                Spacer(minLength: .zero)
                saveButton()
                
                Spacer(minLength: .zero)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("회원정보 수정")
                    .font(.spoqaHan(family: .Regular, size: 18))
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
        VStack(alignment: .leading) {
            Text("이름")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            VStack {
                TextField("이름", text: $name)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
                Rectangle()
                    .frame(height:1)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func phoneNumberEditView() -> some View {
        VStack(alignment: .leading) {
            Text("전화번호")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            VStack {
                TextField("전화번호", text: $phoneNumber)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
                Rectangle()
                    .frame(height:1)
                
            }
            .cornerRadius(4, corners: .allCorners)
            
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func emailView() -> some View {
        VStack(alignment: .leading) {
            Text("email")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            VStack {
                TextField("이메일", text: $email)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
                    .disabled(true)
                    .foregroundColor(Color("Gray"))
                Rectangle()
                    .frame(height:1)
                
            }
            .cornerRadius(4, corners: .allCorners)
            
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            accountViewModel.saveUserInformation(name: name, phoneNumber: phoneNumber)
            if let selectedImage = selectedImage {
                accountViewModel.uploadProfileImage(selectedImage)
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
