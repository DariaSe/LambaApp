//
//  SettingsCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsCoordinator: Coordinator {
    
    var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else { return }
            settingsVC.userInfo = userInfo
        }
    }
    
    var apiService: SettingsApiService = SettingsApiServiceMain()
    
    let settingsVC = SettingsViewController()
    
    func start() {
        settingsVC.coordinator = self
        navigationController.viewControllers = [settingsVC]
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: nil, tag: 2)
        settingsVC.title = Strings.settings
        errorVC.reload = { [weak self] in self?.getUserInfo() }
    }
    
    func getUserInfo() {
        InfoService.getUserInfo() { [weak self] (userInfo, errorMessage) in
            DispatchQueue.main.async {
                if let errorMessage = errorMessage {
                    self?.showFullScreenError(message: errorMessage)
                }
                if let userInfo = userInfo {
                    self?.removeFullScreenError()
                    self?.userInfo = userInfo
                }
            }
        }
    }
    
    func showPhotoPicker() {
        let photoPicker = PhotoPickerViewController()
        settingsVC.add(photoPicker)
        photoPicker.showImagePicker()
        let cropperVC = ImageCropperViewController()
        cropperVC.imageCropped = { [weak self] image in
            self?.apiService.postImage(image) { [weak self] (success, message) in
                DispatchQueue.main.async {
                    let title = success ? Strings.imageChanged : message
                    let alert = UIAlertController.simpleAlert(title: title, message: nil, handler: nil)
                    self?.settingsVC.present(alert, animated: true)
                }
            }
            self?.settingsVC.setImage(image)
        }
        photoPicker.imagePicked = { [weak self] image in
            cropperVC.image = image
            self?.settingsVC.navigationController?.pushViewController(cropperVC, animated: false)
        }
    }
    
    func showChangePasswordScreen() {
        let passwordVC = ChangePasswordViewController()
        passwordVC.changePassword = { [weak self] passInfo in
            self?.showLoadingIndicator()
            self?.apiService.changePassword(passInfo: passInfo) { [weak self] (success, message) in
                DispatchQueue.main.async {
                    self?.removeLoadingIndicator()
                    let title = success ? Strings.passChanged : (message ?? Strings.error)
                    passwordVC.showSimpleAlert(title: title) { [weak self] in
                        if success {
                            self?.navigationController.popViewController(animated: true)
                        }
                        else {
                            passwordVC.clearTextFields()
                        }
                    }
                }
            }
        }
        navigationController.pushViewController(passwordVC, animated: true)
    }
    
    func postUserInfo(_ userInfo: UserInfo) {
        apiService.postUserInfo(userInfo) { [weak self] success, errorMessage  in
            DispatchQueue.main.async {
                if errorMessage != nil || !success {
                    self?.showPopUpError(message: errorMessage ?? Strings.error)
                }
            }
        }
    }
    
    func logout() {
        let alert = UIAlertController(title: "", message: Strings.logoutWarning, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: Strings.yes, style: .destructive) { [weak self] (_) in
            Defaults.token = nil
            self?.userInfo = nil
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainCoordinator = appDelegate.mainCoordinator
            mainCoordinator.start()
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        settingsVC.present(alert, animated: true, completion: nil)
        
    }
}
