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
        VStack(alignment: .leading) {
            Text(stat.title)
                .spoqaHan(family: .Regular, size: 12)
                .foregroundColor(Color.colorAssets.textColor)
            Text(stat.value)
                .spoqaHan(family: .Bold, size: 15)
                .foregroundColor(Color.fontColor.accentColor)
            
            Text(stat.percentageChange?.asPercentString() ?? "")
                .spoqaHan(family: .Regular, size: 12)
                .foregroundColor((stat.percentageChange ?? .zero) >= .zero ? Color.colorAssets.blue.opacity(0.8) : Color.colorAssets.red )
            .opacity(stat.percentageChange == nil ? 0.0: 1.0)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background((stat.percentageChange ?? .zero) == .zero ?
                        Color.clear :
                            (stat.percentageChange ?? .zero) >= .zero ? Color.colorAssets.skyblue4.opacity(0.3) : Color.colorAssets.lightRed.opacity(0.3))
            .clipShape(Capsule())
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
