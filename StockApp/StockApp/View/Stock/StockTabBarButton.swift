//
//  StockTabBarButton.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/20.
//

import SwiftUI

struct StockTabBarButton: View {
    var type : StockConvertViewModel
    @Binding var selectType: StockConvertViewModel
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            ForEach(StockConvertViewModel.allCases, id: \.rawValue) {  item  in
                VStack {
                    Text(item.description)
                        .spoqaHan(family: selectType == item ? .Bold : .Medium, size: 15)
                        .foregroundColor(selectType == item ? Color.white : Color.fontColor.mainFontColor)
                        .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                        .background(selectType == item ? Color.colorAssets.skyblue4.opacity(0.8) : Color.clear)
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.selectType = item
                            }
                        }
                }
                
            }
            Spacer()
        }

        }
    }


struct StockTabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        StockTabBarButton(type: .nsdMarketCap, selectType: .constant(.nsdMarketCap))
    }
}
