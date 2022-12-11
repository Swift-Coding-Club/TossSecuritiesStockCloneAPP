//
//  ProfilViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/10.
//

import Foundation


class ProfilViewModel : ObservableObject {
    var appVersion: String {
        if let appVersion = AppManager.shared.currentAppVersion {
            return String(format: "%@ (최신버전)", appVersion)
        }
        return ""
    }
}
 
