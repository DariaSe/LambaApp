//
//  StartCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 19.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class StartCoordinator: NSObject, FormDelegate {
    
    lazy var navigationController = AppNavigationController()
    
    let startVC = StartViewController()
    
    lazy var loginCoordinator = LoginCoordinator(navigationController: self.navigationController)
    
    lazy var forgotPassCoordinator: ForgotPassCoordinator = {
        return ForgotPassCoordinator(navigationController: self.navigationController)
    }()
    
    lazy var registrationCoordinator: RegistrationCoordinator = {
        return RegistrationCoordinator(navigationController: self.navigationController)
    }()
    
    lazy var executorTabBarVC = ExecutorTabBarController()
    lazy var customerTabBarVC = CustomerTabBarController()
    
    func start() {
        if Defaults.token != nil {
            getUserInfo()
        }
        else {
            showLoginScreen()
        }
    }
    
    func getUserInfo() {
        InfoService.shared.getUserInfo(completion: { [unowned self] userInfo, errorMessage in
            DispatchQueue.main.async {
                if let errorMessage = errorMessage {
                    let errorVC = ErrorViewController()
                    errorVC.message = errorMessage
                    errorVC.reload = { [unowned self] in
                        errorVC.dismiss(animated: true)
                        self.getUserInfo()
                    }
                    errorVC.modalPresentationStyle = .overFullScreen
                    self.startVC.present(errorVC, animated: true)
                }
                if let userInfo = userInfo {
                    if userInfo.role == .executor {
                        self.showExecutorPart()
                    }
                    else {
                        self.showCustomerPart()
                    }
                }
                else {
                    self.showLoginScreen()
                }
            }
        })
    }
    
    func showLoginScreen() {
        if startVC.presentedViewController == nil || startVC.presentedViewController == executorTabBarVC || startVC.presentedViewController == customerTabBarVC {
            loginCoordinator.startCoordinator = self
            loginCoordinator.delegate = self
            loginCoordinator.start()
            let loginVC = loginCoordinator.loginVC
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.viewControllers = [loginVC]
            startVC.present(navigationController, animated: true)
        }
    }
    
    func showExecutorPart() {
        guard let topVC = topViewController() else { return }
        InfoService.shared.delegate = executorTabBarVC
        topVC.present(executorTabBarVC, animated: true)
        executorTabBarVC.getData()
    }
    
    func showCustomerPart() {
        guard let topVC = topViewController() else { return }
        InfoService.shared.delegate = customerTabBarVC
        topVC.present(customerTabBarVC, animated: true)
        customerTabBarVC.getData()
    }
    
    func showForgotPassScreen() {
        forgotPassCoordinator.startCoordinator = self
        forgotPassCoordinator.delegate = self
        forgotPassCoordinator.start()
    }
    
    func showRegistrationScreen() {
        registrationCoordinator.startCoordinator = self
        registrationCoordinator.delegate = self
        registrationCoordinator.start()
    }
    
    func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        return topController
    }
}
