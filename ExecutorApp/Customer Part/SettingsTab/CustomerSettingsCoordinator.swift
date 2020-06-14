//
//  CustomerSettingsCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerSettingsCoordinator: Coordinator {
    
    var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else { return }
            let customerUserInfo = CustomerUserInfo(firstName: userInfo.firstName, lastName: userInfo.lastName, email: userInfo.email)
            settingsVC.userInfo = customerUserInfo
        }
    }
    
    let settingsVC = CustomerSettingsViewController()
    
    let apiService = CustomerSettingsApiService()
    
    func start() {
        navigationController.viewControllers = [settingsVC]
        settingsVC.coordinator = self
        settingsVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let settingsImage = UIImage(named: "Settings")
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: settingsImage, tag: 2)
        settingsVC.title = Strings.settings
        
        errorVC.reload = { [unowned self] in self.getUserInfo() }
    }
    
    func getUserInfo() {
        InfoService.shared.getUserInfo() { [unowned self] (userInfo, errorMessage) in
            DispatchQueue.main.async {
                if let errorMessage = errorMessage {
                    self.showFullScreenError(message: errorMessage)
                }
                if let userInfo = userInfo {
                    self.removeFullScreenError()
                    self.userInfo = userInfo
                }
            }
        }
    }
    
    func setImage(_ image: UIImage?) {
        settingsVC.setImage(image)
    }
    
    func showPhotoPicker() {
        let photoPicker = PhotoPickerViewController()
        settingsVC.add(photoPicker)
        photoPicker.showImagePicker()
        let cropperVC = ImageCropperViewController()
        cropperVC.imageCropped = { [unowned self] image in
            self.apiService.postImage(image) { [unowned self] (success, message) in
                DispatchQueue.main.async {
                    let title = success ? Strings.imageChanged : message
                    let alert = UIAlertController.simpleAlert(title: title, message: nil, handler: nil)
                    self.settingsVC.present(alert, animated: true)
                }
            }
            self.settingsVC.setImage(image)
            InfoService.shared.userImage = image
        }
        photoPicker.imagePicked = { [unowned self] image in
            cropperVC.image = image
            self.navigationController.pushViewController(cropperVC, animated: true)
        }
        photoPicker.accessError = { [unowned self] alert in
            self.settingsVC.present(alert, animated: true)
        }
    }
    
    func requestEmailChange() {
        showLoadingIndicator()
        apiService.sendEmailChangeAuthCode { [unowned self] (success, errorMessage) in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
                else if success {
                    self.showChangeEmailAlert()
                }
            }
        }
    }
    
    func showChangeEmailAlert() {
        let alertController = EmailChangeService.alert { (code, newEmail) in
            self.apiService.changeEmail(code: code, email: newEmail) { [unowned self] (success, errorMessage) in
                DispatchQueue.main.async {
                    if let errorMessage = errorMessage {
                        self.showSimpleAlert(title: errorMessage, handler: nil)
                    }
                    else if success {
                        self.showSimpleAlert(title: Strings.emailChanged, handler: nil)
                        self.getUserInfo()
                    }
                }
            }
        }
        self.settingsVC.present(alertController, animated: true)
    }
    
    func showChangePasswordScreen() {
        let passwordVC = ChangePasswordViewController()
        passwordVC.hidesBottomBarWhenPushed = true
        passwordVC.changePassword = { [unowned self] passInfo in
            self.showLoadingIndicator()
            self.apiService.changePassword(passInfo: passInfo) { [unowned self] (success, message) in
                DispatchQueue.main.async {
                    self.removeLoadingIndicator()
                    let title = success ? Strings.passChanged : (message ?? Strings.error)
                    self.showSimpleAlert(title: title) { [unowned self] in
                        if success {
                            self.navigationController.popViewController(animated: true)
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
    
    func postUserInfo(_ userInfo: CustomerUserInfo) {
        apiService.postUserInfo(userInfo) { [unowned self] success, errorMessage  in
            DispatchQueue.main.async {
                if errorMessage != nil || !success {
                    self.showPopUpError(message: errorMessage ?? Strings.error)
                }
            }
        }
    }
    
    func clearAppearance() {
        settingsVC.scrollToTop()
        userInfo = nil
        InfoService.shared.userImage = InfoService.shared.placeholderImage
    }
    
    func logout() {
        let alert = UIAlertController(title: Strings.logoutWarning, message: "", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
            self.apiService.logout { [unowned self] (success, errorMessage) in
                DispatchQueue.main.async {
                    if let errorMessage = errorMessage {
                        self.showSimpleAlert(title: errorMessage, handler: nil)
                    }
                    if success {
                        self.clearAppearance()
                        Defaults.token = nil
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let startCoordinator = appDelegate.startCoordinator
                        startCoordinator.customerTabBarVC.selectedIndex = 0
                        startCoordinator.customerTabBarVC.dismiss(animated: true, completion: nil)
                        startCoordinator.start()
                    }
                    else {
                        self.showSimpleAlert(title: Strings.error, handler: nil)
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        settingsVC.present(alert, animated: true, completion: nil)
    }
}
