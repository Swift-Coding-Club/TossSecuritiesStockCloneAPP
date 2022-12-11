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
                .spoqaHan(family: .Bold, size: 14)
                .foregroundColor(Color.colorAssets.textColor)
            
            Spacer()
                .frame(height: 10)
            
            Text(stat.value)
                .spoqaHan(family: .Bold, size: 15)
                .foregroundColor(Color.fontColor.mainFontColor)
            
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
        .frame(width: 110, height: 120)
        .background() {
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(Color.colorAssets.backGroundColor)
                .shadow(color: Color.fontColor.accentColor.opacity(0.15),
                         radius: 10, x: .zero, y: .zero)
        }
    }
}

struct CardStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        CardStatisticView(stat: dev.state1)
    }
}
