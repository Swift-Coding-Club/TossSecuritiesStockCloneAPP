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
                .foregroundColor(Color.colorAssets.subColor)
                .font(.custom(FontAsset.mediumFont, size: 23))
                .padding(.top, 10)
                .padding(.leading , 12)
            LazyVGrid(columns: colums,
                      alignment: .leading,
                      spacing:  spacing,
                      pinnedViews: [ ] ) {
                Text(stat.value)
                    .font(.custom(FontAsset.boldFont, size: 15))
                    .foregroundColor(Color.fontColor.accentColor)
                HStack{
                    Spacer(minLength: 45)
                    VStack(alignment: .leading){
                        Text("시세 변화율")
                            .foregroundColor(Color.colorAssets.subColor)
                            .font(.custom(FontAsset.mediumFont, size: 20))
                        HStack(spacing: 4) {
                            Image(systemName: "triangle.fill")
                                .font(.caption2)
                                .rotationEffect(Angle(degrees:
                                                        (stat.percentageChange ?? .zero) >= .zero ? 0 : 180 ))
                            Text(stat.percentageChange?.asPercentString() ?? "")
                                .font(.custom(FontAsset.lightFont, size: 15))
                                .bold()
                        }
                        .foregroundColor((stat.percentageChange ?? .zero) >= .zero ? Color.colorAssets.green : Color.colorAssets.red )
                        .opacity(stat.percentageChange == nil ? 0.0: 1.0)
                        
                    }
                }
            }
                      .padding(.horizontal)
        }
        .padding(.vertical)
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
