//
//  DeveloperView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/20.
//

import SwiftUI

struct DeveloperView: View {
    var body: some View {
        VStack{
            Text("만든 개발자 정보 ")
                .spoqaHan(family: .Medium, size: 30)
        }
    }
        
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
