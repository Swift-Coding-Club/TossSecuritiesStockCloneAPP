//
//  TickerListRowView.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/28.
//

import SwiftUI

struct TickerListRowView: View {
    let data: TickerListRowData
    var body: some View {
        HStack(alignment: .center) {
            if case let .search(isSaved, onButtonTapped) = data.type {
                Button {
                    onButtonTapped()
                } label: {
                    iconImage(isSaved: isSaved)
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(data.symbol)
                    .spoqaHan(family: .Bold, size: 15)
                    .foregroundColor(Color.fontColor.mainFontColor)
                if let name = data.name {
                    Text(name)
                        .spoqaHan(family: .Regular, size: 15)
                        .foregroundColor(Color.colorAssets.textColor)
                }
            }
            
            Spacer()
            
            if let (price, change) = data.price {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(price + " KRW")
                    priceChangeView(title: change)
                }
                .spoqaHan(family: .Bold, size: 15)
            }
        }
    }
    //MARK: - 검색했을때  아이콘 추가
    @ViewBuilder
    private func iconImage(isSaved: Bool) -> some View {
        if isSaved {
            Image(systemName: "checkmark.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.white,  Color.colorAssets.skyblue4.opacity(0.8))
                .imageScale(.large)
        } else {
            Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.colorAssets.skyblue4.opacity(0.9) , Color.fontColor.mainFontColor.opacity(0.7))
                .imageScale(.large)
        }
    }
    //MARK: - 가격 변화량
    @ViewBuilder
    private func priceChangeView(title: String) -> some View {
        if case .main = data.type {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(title.hasPrefix("-") ? Color.colorAssets.lightRed :
                                        Color.colorAssets.skyblue4.opacity(0.8))
                    .frame(height: 24)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .spoqaHan(family: .Bold, size: 13)
                    .padding(.horizontal, 6)
            }
            .fixedSize()
        } else  {
            Text(title)
                .foregroundColor(title.hasPrefix("-") ?
                                 Color.colorAssets.lightRed :
                                    Color.colorAssets.skyblue4.opacity(0.8))
        }
        
    }
}

struct TickerListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Main List").font(.largeTitle.bold()).padding( )
            VStack{
                TickerListRowView(data: appleTikcerListRowData(rowType: .main))
                Divider()
                TickerListRowView(data: teslaTikcerListRowData(rowType: .main))
            }.padding()
            
            Text("search List").font(.largeTitle.bold()).padding( )
            VStack{
                TickerListRowView(data: appleTikcerListRowData(rowType: .search(isSaved: true, onButtonTapped: {})))
                Divider()
                TickerListRowView(data: teslaTikcerListRowData(rowType: .search(isSaved: false, onButtonTapped: {})))
            }.padding()
        }
        .previewLayout(.sizeThatFits)
    }
    
    static func appleTikcerListRowData(rowType: TickerListRowData.RowType) -> TickerListRowData {
        .init(symbol: "AAPL", name: "Apple Inc", price: ("100.0" , "+0.7"), type: rowType)
    }
    
    static func teslaTikcerListRowData(rowType: TickerListRowData.RowType) -> TickerListRowData {
        .init(symbol: "TSLA", name: "Tesla", price: ("250.9" , "-18.6"), type: rowType)
    }
}
