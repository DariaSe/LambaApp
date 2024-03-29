//
//  RegistrationCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class RegistrationCoordinator: Coordinator {
    
    weak var startCoordinator: StartCoordinator?
    
    weak var delegate: FormDelegate?
    
    lazy var registrationVC = RegistrationViewController()
    
    let apiService = RegistrationApiService()
    
    func start() {
        registrationVC.coordinator = self
        navigationController.pushViewController(registrationVC, animated: true)
    }
    
    func register(email: String, password: String, confirmedPassword: String) {
        guard password == confirmedPassword else {
            showSimpleAlert(title: Strings.passNoMatch, handler: nil)
            return
        }
        showLoadingIndicator()
        apiService.register(email: email, password: password, confirmedPassword: confirmedPassword) {  [unowned self] (token, errorMessage) in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                if let token = token {
                    Defaults.token = token
                    self.startCoordinator?.getUserInfo()
                    self.navigationController.popViewController(animated: true)
                }
                else if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
            }
        }
    }
}
