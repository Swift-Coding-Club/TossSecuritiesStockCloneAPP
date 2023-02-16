//
//  SIgnUpVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/07.
//

import SwiftUI
import ExytePopupView

struct SIgnUpVIew: View {
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var nickName: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @State private var checkEmailRegister: Bool = false
    @State private var checkPhoneRegister: Bool = false
    @State private var checkPassowrdRegister: Bool = false
    @State private var checkPasswordRecheck: Bool = false
    @State private var checkUserNameRegister: Bool = false
    @State private var checkNickNameRegister: Bool = false
    
    @Environment(\.dismiss) private var dissmiss
    
    @EnvironmentObject var viewModel: AuthorizationVIewModel
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    init() {
        checkRegisterTextField()
    }
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                    .frame(height: 20)
               
                signUPViewTitle()
                
                ScrollView {
                    //MARK: - 회원가입  필드
                    signUPTextField()
                    
                    signUPButton()
                }
                .bounce(false)
                
                alreadyAccount()
                
                Spacer(minLength: .zero)
            }
            .popup(isPresented: $checkUserNameRegister, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2,  closeOnTap: true, closeOnTapOutside: true,  view: {
                SignupPopupVIew(image: "person", title: "회원가입 양식을 확인 해주세요", alertMessage: "이름을 확인해주세요")
            })
            .popup(isPresented: $checkNickNameRegister, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2,  closeOnTap: true, closeOnTapOutside: true,  view: {
                SignupPopupVIew(image: "person", title: "회원가입 양식을 확인 해주세요", alertMessage: "별명을 확인해주세요")
            })
            .popup(isPresented: $checkEmailRegister, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2,  closeOnTap: true, closeOnTapOutside: true,  view: {
                SignupPopupVIew(image: "envelope", title: "회원가입 양식을 확인 해주세요", alertMessage: "이메일 확인해주세요")
            })
            .popup(isPresented: $checkPhoneRegister, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2,  closeOnTap: true, closeOnTapOutside: true,  view: {
                SignupPopupVIew(image: "phone", title: "회원가입 양식을 확인 해주세요", alertMessage: "핸드폰 번호을 입력해주세요")
            })
            .popup(isPresented: $checkPassowrdRegister, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2,  closeOnTap: true, closeOnTapOutside: true,  view: {
                SignupPopupVIew(image: "lock", title: "회원가입 양식을 확인 해주세요", alertMessage: "비밀번호를 입력해주세요")
            })
            .popup(isPresented: $checkPasswordRecheck, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2,  closeOnTap: true, closeOnTapOutside: true,  view: {
                SignupPopupVIew(image: "lock", title: "회원가입 양식을 확인 해주세요", alertMessage: "비밀번호를  한번더 확인 해주세요")
            })
        }
        .navigationBarHidden(true)
        .foregroundColor(Color.colorAssets.black)
    }
    //MARK: - 회원 가입 타이틀
    @ViewBuilder
    private func signUPViewTitle() -> some View {
        HStack{
            Text("Coin Moya")
                .spoqaHan(family: .Bold, size: 30)
                .foregroundColor(Color.fontColor.mainFontColor)
            
        Rectangle()
                .frame(width: 15, height: 15)
                .rotationEffect(Angle(degrees: 130))
                .foregroundColor(Color.colorAssets.skyblue4)
                .offset(y: -15)
            
        }
        .padding(.bottom, 20)
        .padding()
    }

    //MARK: - 회원가입textfield
    @ViewBuilder
    private func signUPTextField() -> some View {
        VStack(spacing: 25) {
            
            CustomInputField(imageName: "person",
                             placeHolderText: "이름을  입력해주세요",
                             text: $userName)
            
            CustomInputField(imageName: "person",
                             placeHolderText: "닉네임을 입력해주세요",
                             text: $nickName)
            
            CustomInputField(imageName: "envelope",
                             placeHolderText: "이메일을 입력 해주세요",
                             text: $email)
            
            CustomInputField(imageName: "phone",
                             placeHolderText: "핸드폰 번호을 입력해주세요",
                             text: $phoneNumber)
            
            CustomSecureInputField(imageName: "lock",
                                   placeHolderText: "비밀번호를 입력해주세요",
                                   text: $password)
            
            CustomSecureInputField(imageName: "lock",
                                   placeHolderText: "비밀번호를 다시 입력해주세요",
                                   text: $passwordCheck)
        }
        .padding(15)
        .foregroundColor(Color.fontColor.mainFontColor)
    }
    //MARK:  - 로그인 버튼
    @ViewBuilder
    private func signUPButton() -> some View {
        Button {
            checkRegisterTextField()
            viewModel.register(withEmail: email, password: password, nickName: nickName, phoneNumber: phoneNumber, userName: userName)
            
            UIApplication.shared.endEditing()
            
        }label: {
            Text("회원가입")
                .font(.custom(FontAsset.regularFont, size: 20))
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color.colorAssets.navy2)
                .cornerRadius(15)
                .padding()
        }
        .padding(.bottom, keyboardHandler.keyboardHeight)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: .zero, y: .zero)
    }
    //MARK: - 이미 계정이 있으면  로그인 하러 가기 버튼
    @ViewBuilder
    private func alreadyAccount() -> some  View {
        Button  {
            dissmiss()
        } label: {
            HStack {
                Spacer()
                
                Text("이미 계정이 있으신가요?")
                    .spoqaHan(family: .Medium, size: 15)
                Text("로그인 하러 가기")
                    .spoqaHan(family: .Bold, size: 15)
            }
            .padding(.trailing, 50)
        }
        .padding(.bottom , 32)
        .foregroundColor(Color.colorAssets.navy2)
    }
    //MARK: - 유효성 검사
    private func checkRegisterTextField() {
        if !CheckRegister.isValidateNickName(userName) {
            checkUserNameRegister.toggle()
            debugPrint("check userName \(userName)")
        } else if !CheckRegister.isValidateNickName(nickName) {
            checkNickNameRegister.toggle()
        } else if !CheckRegister.isValidateEmail(email)  {
            checkEmailRegister.toggle()
            debugPrint("check email \(email)")
        } else if !CheckRegister.isValidatePhoneNumber(phoneNumber) {
            checkPhoneRegister.toggle()
            debugPrint("check phoneNumber \(phoneNumber)")
        } else if !CheckRegister.isValidatePassword(password) {
            checkPassowrdRegister.toggle()
            debugPrint("check passowrd \(password)")
        }else if !CheckRegister.isValidatePassword(passwordCheck){
            checkPasswordRecheck.toggle()
        } else {}
    }
}

struct SIgnUpVIew_Previews: PreviewProvider {
    static var previews: some View {
        SIgnUpVIew()
    }
}
