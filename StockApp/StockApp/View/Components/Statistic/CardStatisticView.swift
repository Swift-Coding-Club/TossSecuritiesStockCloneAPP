//
//  CardStatisticView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/03.
//

import SwiftUI

struct CardStatisticView: View {
    let stat : StatisticModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.colorAssets.textColor)
            Text(stat.value)
                .font(.custom(FontAsset.boldFont, size: 14))
                .foregroundColor(Color.fontColor.accentColor)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees:
                                            (stat.percentageChange ?? .zero) >= .zero ? 0 : 180 ))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? .zero) >= .zero ? Color.colorAssets.green : Color.colorAssets.red )
            .opacity(stat.percentageChange == nil ? 0.0: 1.0)
        }
        .frame(width: 110, height: 110)
        .background() {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color.colorAssets.backGroundColor)
                .shadow(color: Color.fontColor.accentColor.opacity(0.15),
                         radius: 10, x: .zero, y: .zero)
        }
    }
}

struct CardStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        CardStatisticView(stat: dev.state3)
    }
}
