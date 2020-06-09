//
//  Coordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 11.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class Coordinator: NSObject {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.tintColor = UIColor.textColor
    }
    
    let loadingVC = LoadingViewController(backgroundColor: UIColor.backgroundColor)
    let clearLoadingVC = LoadingViewController(backgroundColor: .clear)
    lazy var errorVC = ErrorViewController()
    lazy var popUpErrorVC = PopupErrorViewController()
    
    func showFullScreenLoading() {
        navigationController.topViewController?.add(loadingVC)
    }
    
    func removeFullScreenLoading() {
        loadingVC.remove()
    }
    
    func showLoadingIndicator() {
        navigationController.topViewController?.add(clearLoadingVC)
    }
    
    func removeLoadingIndicator() {
        clearLoadingVC.remove()
    }
    
    func showFullScreenError(message: String) {
        errorVC.message = message
        errorVC.hasButton = true
        navigationController.topViewController?.add(errorVC)
    }
    
    func removeFullScreenError() {
        errorVC.remove()
    }
    
    func showEmptyScreen(message: String) {
        errorVC.message = message
        errorVC.hasButton = false
        navigationController.topViewController?.add(errorVC)
    }
    
    func removeEmptyScreen() {
        errorVC.remove()
    }
    
    func showPopUpError(message: String) {
        popUpErrorVC.message = message
        navigationController.topViewController?.addChild(popUpErrorVC)
    }
    
    func showSimpleAlert(title: String, message: String? = nil, handler: (() -> Void)?) {
        let alert = UIAlertController.simpleAlert(title: title, message: message) { (_) in
            handler?()
        }
        navigationController.topViewController?.present(alert, animated: true)
    }
}
