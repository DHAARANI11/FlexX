//
//  KeyBoardManager.swift
//  FlexX
//
//  Created by Dhaarani M on 12/08/26.
//

import UIKit

final class KeyBoardManager {
    
    private var scrollView: UIScrollView
    private var contentView: UIView
    private var view: UIView
    
    init(
        scrollView: UIScrollView,
        contentView: UIView,
        view: UIView
    ) {
        self.scrollView = scrollView
        self.contentView = contentView
        self.view = view
    }

    
    func setupKeyboardHandling() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(
        _ notification: Notification
    ) {

        guard
            let keyboardFrame = notification.userInfo?[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? CGRect
        else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight

        guard let firstResponder = findFirstResponder(
            in: contentView
        ) else {
            return
        }

        scrollView.scrollRectToVisible(
            firstResponder.convert(
                firstResponder.bounds,
                to: scrollView
            ),
            animated: true
        )
    }
    
    @objc private func keyboardWillHide(
        _ notification: Notification
    ) {

        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    private func findFirstResponder(
        in view: UIView
    ) -> UIView? {

        if view.isFirstResponder {
            return view
        }

        for subview in view.subviews {

            if let responder = findFirstResponder(
                in: subview
            ) {
                return responder
            }
        }

        return nil
    }
    
    func setupKeyboardDismissGesture() {

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false

        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {

        view.endEditing(true)
    }
    
}
