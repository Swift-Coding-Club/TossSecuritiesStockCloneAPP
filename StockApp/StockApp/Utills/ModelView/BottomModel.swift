//
//  BottomModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/11.
//

import SwiftUI

struct BottomModel: View {
    @State var isShowingModel: Bool = true
    var body: some View {
        VStack{
            Button{
                isShowingModel.toggle()
            }label: {
                Text("model bottomsheet")
            }
        }
        .sheet(isPresented: $isShowingModel) {
            ClosedButtonView()
        }
    }
}

struct BottomModel_Previews: PreviewProvider {
    static var previews: some View {
        BottomModel()
    }
}
