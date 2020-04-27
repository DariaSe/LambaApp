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
    let settingsCoordinator = SettingsCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersCoordinator.start()
        financesCoordinator.start()
        settingsCoordinator.start()
        
        viewControllers = [
            ordersCoordinator.navigationController,
            financesCoordinator.navigationController,
            settingsCoordinator.navigationController]
        
    }
}
