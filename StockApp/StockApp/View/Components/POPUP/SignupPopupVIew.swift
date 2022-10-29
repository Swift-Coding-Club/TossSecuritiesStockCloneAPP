//
//  SignupPopupVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/26.
//

import SwiftUI

struct SignupPopupVIew: View {
    let image: String
    let title: String
    let alertMessage: String
    
    var body: some View {
        HStack(alignment: .center , spacing: 10) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .spoqaHan(family: .Bold, size: 20)
                .foregroundColor(Color.colorAssets.white)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .spoqaHan(family: .Medium, size: 18)
                    .foregroundColor(Color.colorAssets.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                Text(alertMessage)
                    .spoqaHan(family: .Medium, size: 15)
                    .foregroundColor(Color.colorAssets.white)
                    .lineLimit(1)
                Divider().opacity(.zero)
            }
        }
        .padding()
        .frame(width: UIScreen.screenWidth - 70, height: UIScreen.screenHeight  / 8 )
        .background(Color.colorAssets.navy2)
        .cornerRadius(20)
    }
}

struct SignupPopupVIew_Previews: PreviewProvider {
    static var previews: some View {
        SignupPopupVIew(image: "flame", title: "알링", alertMessage: "로그아웃")
    }
}
