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
    
    var navigationController = UINavigationController()
    
    var apiService: SettingsApiService = SettingsApiServiceMain()
    
    let settingsVC = SettingsViewController()
    
    lazy var clearLoadingVC = LoadingViewController(backgroundColor: UIColor.clear)
    
    func start() {
        settingsVC.coordinator = self
        navigationController.viewControllers = [settingsVC]
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: nil, tag: 2)
        settingsVC.title = Strings.settings
    }
    
    func getUserInfo() {
        guard let userInfo = userInfo else {
            guard let token = Defaults.token else { return }
            InfoService.getUserInfo(token: token) { [weak self] (userInfo, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        let errorVC = ErrorViewController()
                        errorVC.message = error.localizedDescription
                        errorVC.reload = { [weak self] in
                            errorVC.dismiss(animated: true)
                            self?.getUserInfo()
                        }
                        errorVC.modalPresentationStyle = .overFullScreen
                        self?.settingsVC.present(errorVC, animated: true)
                    }
                    if let userInfo = userInfo {
                        self?.userInfo = userInfo
                    }
                }
            }
            return
        }
        settingsVC.userInfo = userInfo
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
        passwordVC.title = Strings.changePassword
        passwordVC.changePassword = { [weak self] passInfo in
            passwordVC.add(self?.clearLoadingVC ?? LoadingViewController())
            self?.apiService.changePassword(passInfo: passInfo) { [weak self] (success, message) in
                DispatchQueue.main.async {
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
        }
        navigationController.pushViewController(passwordVC, animated: true)
    }
    
    func postUserInfo(_ userInfo: UserInfo) {
        apiService.postUserInfo(userInfo) { [weak self] (success) in
            
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
