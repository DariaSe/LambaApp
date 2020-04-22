//
//  MainTabBarController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let ordersCoordinator = OrdersCoordinator()
    
    let financesVC = FinancesViewController()
    let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersCoordinator.start()
        
        financesVC.tabBarItem = UITabBarItem(title: "Finances".localized, image: nil, tag: 1)
        financesVC.title = "Finances".localized
        
        settingsVC.tabBarItem = UITabBarItem(title: "Settings".localized, image: nil, tag: 2)
        settingsVC.title = "Settings".localized
        
        
        viewControllers = [
            ordersCoordinator.navigationController,
            UINavigationController(rootViewController: financesVC),
            UINavigationController(rootViewController: settingsVC)]
        
    }
    
    
}
