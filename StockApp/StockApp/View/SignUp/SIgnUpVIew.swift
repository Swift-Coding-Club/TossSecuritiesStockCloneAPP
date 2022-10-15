//
//  SIgnUpVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/07.
//

import SwiftUI

struct SIgnUpVIew: View {
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var nickName: String = ""
    @State private var phoneNumber: String = ""
    @State private var passowrd: String = ""
    
    @State private var checkEmailRegister: Bool = false
    @State private var checkPhoneRegister: Bool = false
    @State private var checkPassowrdRegister: Bool = false
    @State private var checkUserNameRegister: Bool = false
    @State private var checkNickNameRegister: Bool = false
    
    @Environment(\.dismiss) private var dissmiss
    
    @EnvironmentObject var viewModel: SignUpVIewModel
    @StateObject private var keyboardHandler = KeyboardHandler()
    init() {
        checkRegisterTextField()
    }
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            VStack {
                //MARK: - 회원 가입 상단  타이틀
                AuthHeaderView(authTopHeaderTitle: "Get Started",
                               authCenterHeaderTitle: "코인 모여  회원가입 서비스 ",
                               authBottomHeaderTitle: "")
                
                ScrollView {
                    //MARK: - 회원가입  필드
                    signUPTextField()
                    
                    signUPButton()
                 


                    
                    
                    Spacer()
                    //MARK: - 이미계정이 있는 경우 버튼
                    alreadyAccount()
                    
                }
            }
            .ignoresSafeArea(.all)
        }
    }
    //MARK: - 회원가입textfield
    @ViewBuilder
    private func signUPTextField() -> some View {
        VStack(spacing: 40) {
            
            CustomInputField(imageName: "person",
                             placeHolderText: "이름을  입력해주세요",
                             text: $userName)
            
            CustomInputField(imageName: "person",
                             placeHolderText: "별명을 입력 해주세요",
                             text: $nickName)
            
            CustomInputField(imageName: "envelope",
                             placeHolderText: "이메일을 입력 해주세요",
                             text: $email)
            
            CustomInputField(imageName: "phone",
                             placeHolderText: "핸드폰 번호을 입력해주세요",
                             text: $phoneNumber)
            
            CustomSecureInputField(imageName: "lock",
                                   placeHolderText: "비밀번호를 입력해주세요",
                                   text: $passowrd)
        }
        .padding(32)
    }
    //MARK:  - 로그인 버튼
    @ViewBuilder
    private func signUPButton() -> some View {
        Button {
            checkRegisterTextField()
            checkRegisterSIgnUpTextFileld()
            viewModel.register(withEmail: email, password: passowrd, fullname: nickName, phoneNumber: phoneNumber, userName: userName)
            UIApplication.shared.endEditing()
        }label: {
            Text("회원가입")
                .font(.custom(FontAsset.regularFont, size: 20))
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color.colorAssets.mainColor)
                .clipShape(Capsule())
                .padding()
        }
        .padding(.bottom, keyboardHandler.keyboardHeight)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: .zero, y: .zero)
        
        .showCheckAlertMessage(showAlert: $checkUserNameRegister,  message: "이름을 확인해주세요")
        .showCheckAlertMessage(showAlert: $checkNickNameRegister,  message: "별명을 확인해주세요")
        .showCheckAlertMessage(showAlert: $checkEmailRegister, message: "이메일 양식을 확인 해주세요")
        .showCheckAlertMessage(showAlert: $checkPhoneRegister, message: "핸드폰 번호를 확인해주세요")
        //        .showCheckAlertMessage(showAlert: $checkPassowrdRegister,  message: "비밀 번호를 확인해주세요")
    }
    private func checkRegisterSIgnUpTextFileld() {
        checkUserNameRegister.toggle()
        checkNickNameRegister.toggle()
        checkEmailRegister.toggle()
        checkPhoneRegister.toggle()
        checkPassowrdRegister.toggle()
    }
    
    //MARK: - 이미 계정이 있으면  로그인 하러 가기 버튼
    @ViewBuilder
    private func alreadyAccount() -> some  View {
        Button  {
            dissmiss()
        } label: {
            HStack {
                Text("이미 계정이 있으신가요?")
                    .font(.custom(FontAsset.lightFont, size: 13))
                Text("로그인 하러 가기")
                    .font(.custom(FontAsset.mediumFont, size: 15))
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom , 32)
        .foregroundColor(Color.colorAssets.subColor)
    }
    //MARK: - 유효성 검사
    private func checkRegisterTextField() {
        if !CheckRegister.isValidateNickName(userName) {
            debugPrint("check userName \(userName)")
        } else if !CheckRegister.isValidateNickName(nickName) {
            debugPrint("check nickName \(nickName)")
        } else if !CheckRegister.isValidateEmail(email)  {
            debugPrint("check email \(email)")
        } else if !CheckRegister.isValidatePhoneNumber(phoneNumber) {
            debugPrint("check phoneNumber \(phoneNumber)")
        } else if !CheckRegister.isValidatePassword(passowrd) {
            debugPrint("check passowrd \(passowrd)")
        }else {}
    }
}

struct SIgnUpVIew_Previews: PreviewProvider {
    static var previews: some View {
        SIgnUpVIew()
    }
}
