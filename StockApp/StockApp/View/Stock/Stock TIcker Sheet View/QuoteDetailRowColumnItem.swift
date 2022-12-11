//
//  QuoteDetailRowColumnItem.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/04.
//

import Foundation
import SwiftUI

struct QuoteDetailRowColumnItem: Identifiable {
    let id = UUID()
    let rows: [RowItem]
    
    struct RowItem: Identifiable {
        let id = UUID()
        let title: String
        let value : String
    }
}
