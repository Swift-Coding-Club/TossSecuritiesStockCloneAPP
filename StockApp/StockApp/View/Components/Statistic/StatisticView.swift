//
//  StatisticView.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/25.
//

import SwiftUI

struct StatisticView: View {
    let stat : StatisticModel
    var body: some View {
        VStack {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.colorAssets.textColor)
            Text(stat.value)
                .font(.headline)
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
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.state1)
            
        }
    }
}
