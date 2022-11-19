//
//  ProfileEditMainView.swift
//  StockApp
//
//  Created by 권승용 on 2022/11/15.
//

import SwiftUI

// MARK: - 프로필 수정 뷰
struct ProfileEditMainView: View {
    @State var name: String = ""
    @State var phoneNumber: String = ""
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
            VStack(spacing: 40){
                Spacer()
                    .frame(height: 10)
                
                imageEditView()
                
                VStack(spacing: 20) {
                    
                    nameEditView()
                    phoneNumberEditView()
                    emailView()
                }
                
                Spacer(minLength: .zero)
            }
        }
    }
    
    @ViewBuilder
    func imageEditView() -> some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .frame(width: 120)
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 30))
                    .background(.white)
                    .cornerRadius(10, corners: .allCorners)
                    .offset(x: 40, y: 40)
            }
        }
    }
    
    @ViewBuilder
    func nameEditView() -> some View {
        VStack(alignment: .leading) {
            Text("이름")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            ZStack {
                TextField("홍길동", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
            }
            .cornerRadius(4, corners: .allCorners)

        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func phoneNumberEditView() -> some View {
        VStack(alignment: .leading) {
            Text("전화번호")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            ZStack {
                TextField("010-000-0000", text: $phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
                
            }
            .cornerRadius(4, corners: .allCorners)
            
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func emailView() -> some View {
        VStack(alignment: .leading) {
            Text("email")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            ZStack {
                TextField("abc123@gmail.com", text: $phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
                    .disabled(true)
                
            }
            .cornerRadius(4, corners: .allCorners)
            
        }
        .padding(.horizontal)
    }
}

struct ProfileEditMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditMainView()
    }
}
