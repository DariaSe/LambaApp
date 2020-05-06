//
//  MainCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class MainCoordinator {
    
    let mainVC = MainTabBarController()
    let startVC = StartViewController()

    let loginCoordinator = LoginCoordinator()
    
    func start() {
        startVC.remove()
        mainVC.coordinator = self
        loginCoordinator.mainCoordinator = self
        loginCoordinator.delegate = mainVC
        loginCoordinator.start()
        mainVC.present(loginCoordinator.loginVC, animated: false)
        if let token = Defaults.token {
            loginCoordinator.loginVC.add(startVC)
            getUserInfo(token: token)
        }
    }
    
    func getUserInfo(token: String) {
        InfoService.getUserInfo(token: token, completion: { [weak self] userInfo, error in
            DispatchQueue.main.async {
                if let error = error {
                    let errorVC = ErrorViewController()
                    errorVC.message = error.localizedDescription
                    errorVC.reload = { [weak self] in
                        errorVC.dismiss(animated: true)
                        self?.getUserInfo(token: token)
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
