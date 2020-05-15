//
//  MainCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorMainCoordinator {
    
    let mainVC = ExecutorTabBarController()
    let startVC = StartViewController()

    let loginCoordinator = LoginCoordinator()
    
    func start() {
        startVC.remove()
        mainVC.coordinator = self
        loginCoordinator.mainCoordinator = self
        loginCoordinator.delegate = mainVC
        loginCoordinator.start()
        mainVC.present(loginCoordinator.loginVC, animated: false)
        if Defaults.token != nil {
            loginCoordinator.loginVC.add(startVC)
            getUserInfo()
        }
    }
    
    func getUserInfo() {
        InfoService.getUserInfo(completion: { [weak self] userInfo, errorMessage in
            DispatchQueue.main.async {
                if let errorMessage = errorMessage {
                    let errorVC = ErrorViewController()
                    errorVC.message = errorMessage
                    errorVC.reload = { [weak self] in
                        errorVC.dismiss(animated: true)
                        self?.loginCoordinator.loginVC.add(self?.startVC ?? StartViewController())
                        self?.getUserInfo()
                    }
                    errorVC.modalPresentationStyle = .overFullScreen
                    self?.loginCoordinator.loginVC.present(errorVC, animated: true)
                }
                if let userInfo = userInfo {
                    self?.mainVC.settingsCoordinator.userInfo = userInfo
                    self?.loginCoordinator.loginVC.dismiss(animated: true, completion: nil)
                    self?.mainVC.getData()
                }
                else {
                    self?.startVC.remove()
                }
            }
        })
    }
}
