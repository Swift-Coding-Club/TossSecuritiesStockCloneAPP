//
//  MyProfileEditView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/15.
//

import SwiftUI

// MARK: - 프로필 수정 뷰
struct MyProfileEditView: View {
    @State var name: String = ""
    @State var phoneNumber: String = ""
    
    var body: some View {
        ZStack {
            Color.colorAssets.backGroundColor
            
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
            
            VStack {
                TextField("홍길동", text: $name)
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
    func phoneNumberEditView() -> some View {
        VStack(alignment: .leading) {
            Text("전화번호")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            VStack {
                TextField("010-000-0000", text: $phoneNumber)
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
    func emailView() -> some View {
        VStack(alignment: .leading) {
            Text("email")
                .font(.spoqaHan(family: .Medium, size: 18))
            
            VStack {
                TextField("abc123@gmail.com", text: $phoneNumber)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .keyboardType(.namePhonePad)
                    .disabled(true)
                Rectangle()
                    .frame(height:1)
                
            }
            .cornerRadius(4, corners: .allCorners)
            
        }
        .padding(.horizontal)
    }
}

struct MyProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileEditView()
    }
}
