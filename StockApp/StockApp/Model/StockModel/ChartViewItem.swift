//
//  ChartViewItem.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/05.
//

import Foundation
import SwiftUI

struct ChartViewItem: Identifiable {
    
    let id  = UUID()
    let timestamp: Date    //MARK: - 시간
    let value : Double       //MARK: - 값
     
}
