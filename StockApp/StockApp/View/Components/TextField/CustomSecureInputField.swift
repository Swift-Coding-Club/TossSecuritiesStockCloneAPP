//
//  CustomSecureInputField.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/11.
//

import SwiftUI

struct CustomSecureInputField: View {
    let imageName: String
    let placeHolderText: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                SecureField(placeHolderText, text: $text)
                    .spoqaHan(family: .Regular, size: 20)
                
            }
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.darkGray), lineWidth: 1)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: .zero, y: .zero)
            )
        }
        .padding(20)
        .frame(width: UIScreen.screenWidth ,height: 50)
    }
}

struct CustomSecureInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureInputField(imageName: "flame",
                               placeHolderText: "Email",
                               text: .constant(""))
    }
}
