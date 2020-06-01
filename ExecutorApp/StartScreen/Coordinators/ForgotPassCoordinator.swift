//
//  ForgotPassCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ForgotPassCoordinator: Coordinator {
    
    weak var startCoordinator: StartCoordinator?
    
    weak var delegate: FormDelegate?
    
    let apiService = ForgotPassApiService()
    
    lazy var emailVC = ForgotPassEmailViewController()
    lazy var resetPassVC = ResetPassViewController()
    
    func start() {
        emailVC.coordinator = self
        navigationController.pushViewController(emailVC, animated: true)
    }
    
    func requestAuthCode(email: String) {
        showLoadingIndicator()
        apiService.requestAuthCode(email: email) { [unowned self] (success, errorMessage) in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
                else if success {
                    self.showResetPassScreen(email: email)
                }
            }
        }
    }
    
    func showResetPassScreen(email: String) {
        resetPassVC.coordinator = self
        resetPassVC.email = email
        navigationController.pushViewController(resetPassVC, animated: true)
    }
    
    func sendCodeAndPassword(code: String, email: String, password: String, confirmedPassword: String) {
        showLoadingIndicator()
        apiService.sendCodeAndPassword(code: code, email: email, password: password, confirmedPassword: password) { [unowned self] (token, errorMessage) in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                if let token = token {
                    Defaults.token = token
                    self.startCoordinator?.getUserInfo()
                }
                else if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
            }
        }
    }
}
