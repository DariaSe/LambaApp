//
//  StatesViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 10.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class StatesViewController: UIViewController {
    
    var reload: (() -> Void)?
    
    lazy var loadingVC: LoadingViewController = {
        return LoadingViewController(backgroundColor: UIColor.backgroundColor)
       }()
    
    lazy var clearLoadingVC: LoadingViewController = {
        return LoadingViewController(backgroundColor: UIColor.clear)
    }()
    
    lazy var errorVC: ErrorViewController = {
        return ErrorViewController()
    }()
    
    lazy var popUpErrorVC: PopupErrorViewController = {
        return PopupErrorViewController()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showFullScreenLoading() {
        add(loadingVC)
    }
    
    func removeFullScreenLoading() {
        loadingVC.remove()
    }
    
    func showLoadingIndicator() {
        add(clearLoadingVC)
    }
    
    func removeLoadingIndicator() {
        clearLoadingVC.remove()
    }
    
    func showFullScreenError(message: String) {
//        errorVC.message = message
//        errorVC.reload = self.reload
        let anotherErrorVC = ErrorViewController()
        anotherErrorVC.message = message
        add(anotherErrorVC)
    }
    
    func removeFullScreenError() {
        errorVC.message = ""
        errorVC.remove()
    }
    
    func showPopUpError(message: String) {
        popUpErrorVC.message = message
        add(popUpErrorVC)
    }
    
    func showSimpleAlert(title: String, handler: (() -> Void)?) {
        let alert = UIAlertController.simpleAlert(title: title, message: nil) { (_) in
            handler?()
        }
        self.present(alert, animated: true)
    }
}
