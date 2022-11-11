//
//  ProfileEditView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/11.
//

import SwiftUI

struct ProfileEditView: View {
    let image: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 20, height: 23)
                .foregroundColor(Color.colorAssets.iconColor)
            
            Spacer()
                .frame(height: 20)
            
            Text(title)
                .spoqaHan(family: .Regular, size: 18)
        }
       
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(image: "flame", title: "불")
    }
}
