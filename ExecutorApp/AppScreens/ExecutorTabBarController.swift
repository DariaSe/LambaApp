//
//  MainTabBarController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorTabBarController: AppTabBarController {
    
    let ordersCoordinator = ExecutorOrdersCoordinator(navigationController: AppNavigationController())
    let financesCoordinator = FinancesCoordinator(navigationController: AppNavigationController())
    let settingsCoordinator = SettingsCoordinator(navigationController: AppNavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        ordersCoordinator.start()
        financesCoordinator.start()
        settingsCoordinator.start()
        
        viewControllers = [
            ordersCoordinator.navigationController,
            financesCoordinator.navigationController,
            settingsCoordinator.navigationController]
        
        ordersCoordinator.ordersVC.delegate = self
    }
    
    func getData() {
        DispatchQueue.main.async { [unowned self] in
            self.ordersCoordinator.getOrders()
            self.financesCoordinator.getFinancesInfo()
            self.settingsCoordinator.getUserInfo()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Defaults.tokenKey {
            getData()
        }
    }
}

extension ExecutorTabBarController: UserImageDelegate {
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.ordersCoordinator.setImage(image)
            self.settingsCoordinator.setImage(image)
        }
    }
}
