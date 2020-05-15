//
//  LoginCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LoginCoordinator {
    
    weak var mainCoordinator: ExecutorMainCoordinator?
    
    let loginVC = LoginViewController()
    
    let loginService = LoginService()
    
    var delegate: LoginDelegate?
    
    func start() {
        loginVC.loginCoordinator = self
        loginVC.modalPresentationStyle = .overFullScreen
    }
    
    func login(email: String, password: String) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center(in: loginVC.view)
        activityIndicator.startAnimating()
        loginService.login(email: email, password: password) { [weak self] (token, errorMessage) in
            if let token = token {
                Defaults.token = token
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self?.delegate?.showOrders()
                    self?.loginVC.restoreAppearance()
                    self?.loginVC.dismiss(animated: true, completion: nil)
                }
            }
            else if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self?.showLoginFailed(message: errorMessage)
                }
            }
        }
    }
    
    func showLoginFailed(message: String) {
        let alert = UIAlertController.simpleAlert(title: Strings.loginFailed, message: message) { [weak self] (_) in
            self?.loginVC.restoreAppearance()
        }
        loginVC.present(alert, animated: true)
    }
}


protocol LoginDelegate {
    func showOrders()
}
