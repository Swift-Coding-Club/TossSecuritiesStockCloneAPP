//
//  ViewRouter.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/15.
//

import SwiftUI
import Combine
import Foundation

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter, Never> ()
    
    
    var currentPage: String = "page1" {
            didSet{
                objectWillChange.send(self)
            }
        }
    
}
