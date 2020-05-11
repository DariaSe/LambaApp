//
//  MainTabBarController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    weak var coordinator: MainCoordinator?
    
    let ordersCoordinator = OrdersCoordinator()
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

extension MainTabBarController: LoginDelegate {
    func showOrders() {
        selectedIndex = 0
        getData()
    }
}
