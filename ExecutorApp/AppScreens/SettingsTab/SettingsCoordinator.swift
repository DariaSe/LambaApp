//
//  SettingsCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsCoordinator: Coordinator {
    
    var navigationController = UINavigationController()
    
    var apiService: SettingsApiService = SettingsApiServiceMock()
    
    let settingsVC = SettingsViewController()
    
    func start() {
        settingsVC.coordinator = self
        navigationController.viewControllers = [settingsVC]
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: nil, tag: 2)
        settingsVC.title = Strings.settings
        getUserInfo()
    }
    
    func getUserInfo() {
        apiService.getUserInfo { [weak self] (userInfo) in
            if let userInfo = userInfo {
                self?.settingsVC.userInfo = userInfo
            }
            else {
                
            }
        }
    }
    
    func showPhotoPicker() {
        print("show photo picker")
        let photoPicker = PhotoPickerViewController()
        settingsVC.add(photoPicker)
        photoPicker.showImagePicker()
        photoPicker.imagePicked = { [weak self] image in
            if var userInfo = self?.settingsVC.userInfo {
                userInfo.image = image
                self?.settingsVC.userInfo = userInfo
                self?.apiService.userInfo = userInfo
                self?.apiService.postUserInfo(userInfo) { (success) in
                    print("post successed")
                }
            }
        }
    }
    
    func showChangePasswordScreen() {
        
    }
    
    
}
