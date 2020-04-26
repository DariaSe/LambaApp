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
    let financesCoordinator = FinancesCoordinator()
 
    let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersCoordinator.start()
        financesCoordinator.start()
        
        settingsVC.tabBarItem = UITabBarItem(title: "Settings".localized, image: nil, tag: 2)
        settingsVC.title = "Settings".localized
        
        
        viewControllers = [
            ordersCoordinator.navigationController,
            financesCoordinator.navigationController,
            UINavigationController(rootViewController: settingsVC)]
        
    }
    
    
}
