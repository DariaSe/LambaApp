//
//  p_KeyboardHandler.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

protocol KeyboardHandler where Self: UIViewController {
    var scrollView: UIScrollView { get set }
    func registerForKeyboardNotifications()
}

extension KeyboardHandler {
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWasShown(notification)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] _ in
            self?.keyboardWillBeHidden()
        }
    }
    
    func keyboardWasShown(_ notification: Notification) {
//        scrollView.contentSize = scrollView.bounds.size
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize!.height - (self.navigationController?.tabBarController?.tabBar.frame.height ?? 0), right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    func keyboardWillBeHidden() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        view.endEditing(true)
    }
}

