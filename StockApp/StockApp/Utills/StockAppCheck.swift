//
//  StockAppCheck.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/30.
//

import Foundation
import FirebaseAppCheck
import Firebase

class StockAppCheck : NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
      if #available(iOS 14.0, *) {
        return AppAttestProvider(app: app)
      } else {
        return DeviceCheckProvider(app: app)
      }
    }
  }
