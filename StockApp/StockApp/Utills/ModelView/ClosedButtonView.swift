//
//  ClosedButtonView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/11.
//

import SwiftUI

struct ClosedButtonView: View {
    @Environment(\.dismiss)  var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.white)
            
            Button{
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(20)
            }
        }
        .cornerRadius(30)
    }
}

struct ClosedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedButtonView()
    }
}
