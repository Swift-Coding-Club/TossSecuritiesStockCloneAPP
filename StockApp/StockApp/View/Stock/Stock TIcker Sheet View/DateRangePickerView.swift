//
//  DateRangePickerView.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import SwiftUI
import XCAStocksAPI

struct DateRangePickerView: View {
    
    let rangeTypes = ChartRange.allCases
    @Binding var selectedRange: ChartRange
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(self.rangeTypes) { dateRange in
                    Button {
                        self.selectedRange = dateRange
                    } label: {
                        Text(dateRange.title)
                            .spoqaHan(family: .Bold, size: 15)
                            .foregroundColor(Color.fontColor.mainFontColor)
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    .background {
                        if dateRange == selectedRange {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.4))
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .bounce(false)
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    
    @State static var dateRange = ChartRange.oneDay
    
    static var previews: some View {
        DateRangePickerView(selectedRange: $dateRange)
            .padding(.vertical)
            .previewLayout(.sizeThatFits)
    }
}
