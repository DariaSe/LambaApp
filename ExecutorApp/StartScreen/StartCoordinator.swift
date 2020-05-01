//
//  StartCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class StartCoordinator {
    
    let mainVC = MainTabBarController()
    let loginVC = LoginViewController()
    let startVC = StartViewController()
    
    func start() {
        loginVC.modalPresentationStyle = .overFullScreen
        mainVC.present(loginVC, animated: false)
        if let token = Defaults.token {
            loginVC.add(startVC)
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
                    self?.loginVC.present(errorVC, animated: true)
                }
                if let userInfo = userInfo {
                    self?.mainVC.settingsCoordinator.userInfo = userInfo
                    self?.loginVC.dismiss(animated: true, completion: nil)
                }
                else {
                    self?.startVC.remove()
                }
            }
        })
    }
}
