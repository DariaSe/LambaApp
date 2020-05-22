//
//  LoginCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    weak var startCoordinator: StartCoordinator?
    
    weak var delegate: FormDelegate?
    
    let loginVC = LoginViewController()
    
    let loginService = LoginService()
    
    func start() {
        loginVC.loginCoordinator = self
        loginVC.modalPresentationStyle = .overFullScreen
        loginVC.delegate = self.delegate
    }
    
    func login(email: String, password: String) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center(in: loginVC.view)
        activityIndicator.startAnimating()
        loginService.login(email: email, password: password) { [unowned self] (token, errorMessage) in
            if let token = token {
                Defaults.token = token
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.loginVC.restoreAppearance()
                    self.startCoordinator?.getUserInfo()
                }
            }
            else if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.showLoginFailed(message: errorMessage)
                }
            }
        }
    }
    
    func showLoginFailed(message: String) {
        let alert = UIAlertController.simpleAlert(title: Strings.loginFailed, message: message) { [unowned self] (_) in
            self.loginVC.restoreAppearance()
        }
        loginVC.present(alert, animated: true)
    }
}
