//
//  GoogleLoginButton.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/22.
//

import SwiftUI
import GoogleSignIn


struct GoogleLoginButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    private var button = GIDSignInButton()

    func makeUIView(context: Context) -> GIDSignInButton {
      button.colorScheme = colorScheme == .dark ? .dark : .light
      return button
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
      button.colorScheme = colorScheme == .dark ? .dark : .light
    }
  }
