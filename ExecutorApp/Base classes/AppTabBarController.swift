//
//  AppTabBarController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .fullScreen
        UserDefaults.standard.addObserver(self, forKeyPath: Defaults.tokenKey, options: .new, context: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.barStyle = .default
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.borderWidth = 1.0
        tabBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newHeight = tabBar.frame.size.height + 10
        tabBar.frame.size.height = newHeight
        tabBar.frame.origin.y = view.frame.height - newHeight
    }
}


extension AppTabBarController: UserButtonDelegate {
    func showSettings() {
        selectedIndex = 2
    }
}
