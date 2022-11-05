//
//  CustomInputField.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/11.
//

import SwiftUI

struct CustomInputField: View {
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
                
                Spacer()
                    .frame(width: 10)
                
                TextField(placeHolderText, text: $text)
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

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "flame",
                                    placeHolderText: "Email",
                         text: .constant(""))
    }
}
