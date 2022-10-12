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
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomSecureInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureInputField(imageName: "flame",
                               placeHolderText: "Email",
                               text: .constant(""))
    }
}
