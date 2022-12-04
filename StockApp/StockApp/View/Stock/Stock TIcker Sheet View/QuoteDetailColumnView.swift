//
//  QuoteDetailColumnView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import SwiftUI

 struct QuoteDetailColumnView: View {
     let item : QuoteDetailRowColumnItem
     
    var body: some View {
        VStack(spacing: 6) {
            ForEach(item.rows) { row in
                HStack(alignment: .lastTextBaseline) {
                    Text(row.title)
                        .kerning(-0.3)
                        .foregroundColor(Color.colorAssets.textColor)
                    Spacer()
                    Text(row.value)
                        .foregroundColor(Color.fontColor.mainFontColor)
                }
                .spoqaHan(family: .Regular, size: 13)
            }
            
        }
        .frame(width: 130)
    }
}

struct QuoteDetailColumnView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteDetailColumnView(
            item: .init(rows: [
                .init(title: "open", value: "164.23"),
                .init(title: "open", value: "164.23"),
                .init(title: "open", value: "164.23")
            ])
        )
        .previewLayout(.sizeThatFits)
    }
}
