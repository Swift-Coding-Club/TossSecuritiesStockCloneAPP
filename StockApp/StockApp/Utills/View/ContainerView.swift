//
//  ContainerView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/22.
//

import SwiftUI
import UIKit

struct ContainerView<Content>: UIViewControllerRepresentable where Content : View {
    let content: (UIViewController) -> Content

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIHostingController(rootView: AnyView(MainTabVIew()))
        vc.rootView = AnyView(content(vc))
        return vc
    }

    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        
    }

    class Coordinator: NSObject {
        var parent: ContainerView

        init(_ viewController: ContainerView) {
            parent = viewController
        }
    }
}

