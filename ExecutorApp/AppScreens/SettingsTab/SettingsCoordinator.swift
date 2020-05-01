//
//  SettingsCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsCoordinator: Coordinator {
    
    var userInfo: UserInfo?
    
    var navigationController = UINavigationController()
    
    var apiService: SettingsApiService = SettingsApiServiceMock()
    
    let settingsVC = SettingsViewController()
    
    lazy var clearLoadingVC = LoadingViewController(backgroundColor: UIColor.clear)
    
    func start() {
        settingsVC.coordinator = self
        navigationController.viewControllers = [settingsVC]
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: nil, tag: 2)
        settingsVC.title = Strings.settings
        getUserInfo()
    }
    
    func getUserInfo() {
//        apiService.getUserInfo { [weak self] (userInfo) in
//            if let userInfo = userInfo {
//                self?.settingsVC.userInfo = userInfo
//            }
//            else {
//
//            }
//        }
        settingsVC.userInfo = UserInfo.sample()
    }
    
    func showPhotoPicker() {
        let photoPicker = PhotoPickerViewController()
        settingsVC.add(photoPicker)
        photoPicker.showImagePicker()
        photoPicker.imagePicked = { [weak self] image in
            self?.settingsVC.setImage(image)
        }
    }
    
    func showChangePasswordScreen() {
        let passwordVC = ChangePasswordViewController()
        passwordVC.title = Strings.changePassword
        passwordVC.changePassword = { [weak self] passInfo in
            passwordVC.add(self?.clearLoadingVC ?? LoadingViewController())
            self?.apiService.changePassword(passInfo: passInfo) { [weak self] (success, message) in
                self?.clearLoadingVC.remove()
                let title = success ? Strings.passChanged : message
                let alert = UIAlertController.simpleAlert(title: title, message: nil) { [weak self] (_) in
                    if success {
                        self?.navigationController.popViewController(animated: true)
                    }
                    else {
                        passwordVC.clearTextFields()
                    }
                }
                passwordVC.present(alert, animated: true, completion: nil)
            }
        }
        navigationController.pushViewController(passwordVC, animated: true)
    }
    
    func postUserInfo(_ userInfo: UserInfo) {
        settingsVC.add(clearLoadingVC)
        apiService.postUserInfo(userInfo) { [weak self] (success) in
            self?.clearLoadingVC.remove()
            let title = success ? Strings.settingsChanged : Strings.error
            let alert = UIAlertController.simpleAlert(title: title, message: nil, handler: nil)
            self?.settingsVC.present(alert, animated: true, completion: nil)
        }
    }
    
    func logout() {
        let alert = UIAlertController(title: "", message: Strings.logoutWarning, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: Strings.yes, style: .destructive) { (_) in
            let loginVC = LoginViewController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = loginVC
            #warning("delete token and password here")
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        settingsVC.present(alert, animated: true, completion: nil)
        
    }
}
