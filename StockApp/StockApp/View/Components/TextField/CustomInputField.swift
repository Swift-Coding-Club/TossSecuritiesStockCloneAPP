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
                
                TextField(placeHolderText, text: $text)
                    .font(.custom(FontAsset.shareCircleFont, size: 20))
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "flame",
                                    placeHolderText: "Email",
                         text: .constant(""))
    }
}
