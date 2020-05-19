//
//  MainTabBarController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorTabBarController: UITabBarController {
    
    weak var coordinator: ExecutorMainCoordinator?
    
    let ordersCoordinator = ExecutorOrdersCoordinator()
    let financesCoordinator = FinancesCoordinator()
    let settingsCoordinator = SettingsCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.addObserver(self, forKeyPath: Defaults.tokenKey, options: .new, context: nil)
        
        ordersCoordinator.start()
        financesCoordinator.start()
        settingsCoordinator.start()
        
        viewControllers = [
            ordersCoordinator.navigationController,
            financesCoordinator.navigationController,
            settingsCoordinator.navigationController]
        
        ordersCoordinator.ordersVC.delegate = self
        
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
    func getData() {
        DispatchQueue.main.async { [weak self] in
            self?.ordersCoordinator.getOrders()
            self?.financesCoordinator.getFinancesInfo()
            self?.settingsCoordinator.getUserInfo()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Defaults.tokenKey {
            getData()
        }
    }
}

extension ExecutorTabBarController: LoginDelegate {
    func showOrders() {
        selectedIndex = 0
        getData()
    }
}

extension ExecutorTabBarController: UserButtonDelegate {
    func showSettings() {
        selectedIndex = 2
    }
}
