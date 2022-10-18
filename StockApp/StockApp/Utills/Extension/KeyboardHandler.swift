//
//  KeyboardAvoid.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/14.
//

import SwiftUI
import Combine

final class KeyboardHandler: ObservableObject {
    //MARK: - 키보드의 높이 조절
    @Published private(set) var keyboardHeight: CGFloat = 0 {
        didSet {
            showKeyboard = keyboardHeight > 0
        }
    }
    
    @Published var showKeyboard = false

    private var cancellable: AnyCancellable?

    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }

    private let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }

    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide).subscribe(on: DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
}
