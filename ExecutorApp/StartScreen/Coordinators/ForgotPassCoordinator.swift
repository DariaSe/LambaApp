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
    lazy var authCodeVC = AuthCodeViewController()
    lazy var resetPassVC = ResetPassViewController()
    
    func start() {
        emailVC.coordinator = self
        navigationController.pushViewController(emailVC, animated: true)
    }
    
    func requestAuthCode(email: String) {
        showLoadingIndicator()
        apiService.requestAuthCode(email: email) { [unowned self] (success, errorMessage) in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showSimpleAlert(title: errorMessage, handler: nil)
            }
            else if success {
                self.showAuthCodeScreen()
            }
        }
    }
    
    func showAuthCodeScreen() {
        authCodeVC.coordinator = self
        navigationController.pushViewController(authCodeVC, animated: true)
    }
    
    func sendAuthCode(code: String) {
        showLoadingIndicator()
        apiService.sendAuthCode(code: code) {  [unowned self] (success, errorMessage) in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showSimpleAlert(title: errorMessage, handler: nil)
            }
            else if success {
                self.showResetPassScreen()
            }
        }
    }
    
    func showResetPassScreen() {
        resetPassVC.coordinator = self
        navigationController.pushViewController(resetPassVC, animated: true)
    }
    
    func sendPassword(old: String, new: String) {
        showLoadingIndicator()
        apiService.sendPassword(old: old, new: new) { [unowned self] (success, errorMessage) in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showSimpleAlert(title: errorMessage, handler: nil)
            }
            else if success {
                self.startCoordinator?.start()
            }
        }
    }
}
