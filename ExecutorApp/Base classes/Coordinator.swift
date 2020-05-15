//
//  Coordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 11.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class Coordinator: NSObject {
    
    var navigationController = UINavigationController()
    
    let loadingVC = LoadingViewController(backgroundColor: UIColor.backgroundColor)
    let clearLoadingVC = LoadingViewController(backgroundColor: .clear)
    let errorVC = ErrorViewController()
    let popUpErrorVC = PopupErrorViewController()
    
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
        navigationController.topViewController?.add(errorVC)
    }
    
    func removeFullScreenError() {
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
