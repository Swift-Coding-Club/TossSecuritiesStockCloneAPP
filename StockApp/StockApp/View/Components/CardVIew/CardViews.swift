//
//  CardViews.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/02.
//

import SwiftUI

struct CardViews: View {
    let stat : StatisticModel
    private let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())]     // griditem 관련
    private let spacing: CGFloat = 10    // griditem spacing 관련
    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .spoqaHan(family: .Medium, size: 14)
                .foregroundColor(Color.colorAssets.textColor)
                .padding(.top, 10)
                .padding(.leading , 15)
            
            LazyVGrid(columns: colums,
                      alignment: .leading,
                      spacing:  spacing,
                      pinnedViews: [ ] ) {
                Text(stat.value)
                    .kerning(-0.5)
                    .spoqaHan(family: .Bold, size: 23)
                    .foregroundColor(Color.fontColor.mainFontColor)
        
                        HStack {
                            Text("KRW")
                                .spoqaHan(family: .Bold, size: 14)
                                .foregroundColor(Color.colorAssets.white)
                                .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.colorAssets.skyblue4)
                                    .frame(width: 51, height: 25)
                                )
                                .padding(.horizontal, 10)
                            
                            Spacer()
                                .frame(width: 12)
                                
                            Text(stat.percentageChange?.asPercentString() ?? "")
                                .spoqaHan(family: .Regular, size: 12)
                                .foregroundColor((stat.percentageChange ?? .zero) >= .zero ? Color.colorAssets.skyblue4.opacity(0.8) : Color.colorAssets.red )
                        .opacity(stat.percentageChange == nil ? 0.0: 1.0)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .background((stat.percentageChange ?? .zero) >= .zero ? Color.colorAssets.skyblue4.opacity(0.3) : Color.colorAssets.lightRed.opacity(0.3))
                        .clipShape(Capsule())
                            
                        }
                Spacer()
                }
                      .padding(.horizontal)
            Spacer()
        }
        .padding(.vertical)
        .frame(width: ContentsWidth, height: 100)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color.colorAssets.backGroundColor)
                .shadow(color:Color.fontColor.accentColor.opacity(0.15), radius: 5, x: .zero, y: .zero)
        )
        .padding(.horizontal, 20)
       
    }
}

struct CardViews_Previews: PreviewProvider {
    static var previews: some View {
        CardViews(stat: dev.state3)
    }
}
