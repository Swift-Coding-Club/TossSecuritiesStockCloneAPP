//
//  String.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/04.
//

import Foundation

extension String {
    //MARK: - html에서 <, br 찾기 는 확장자

    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
