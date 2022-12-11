//
//  FetchPhase.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/29.
//

import Foundation

enum FetchPhase<V> {
    case initial
    case fetching
    case success(V)
    case failuer(Error)
    case empty
    
    var value: V? {
        if case .success(let v) = self {
            return v
        }
        return nil
    }
    var error: Error? {
        if case .failuer(let error) = self {
            return error
        }
        return nil
            
    }
    
}
