//
//  CustomerTabBarController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerTabBarController: AppTabBarController {
    
    let executorsCoordinator = ExecutorsTabCoordinator(navigationController: AppNavigationController())
    let ordersCoordinator = CustomerOrdersCoordinator(navigationController: AppNavigationController())
    let settingsCoordinator = CustomerSettingsCoordinator(navigationController: AppNavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        executorsCoordinator.start()
        ordersCoordinator.start()
        settingsCoordinator.start()
        
        viewControllers = [
            executorsCoordinator.navigationController,
            ordersCoordinator.navigationController,
            settingsCoordinator.navigationController]
        
         executorsCoordinator.executorsListVC.delegate = self
        
    }
    
    func getData() {
        DispatchQueue.main.async { [unowned self] in
            self.executorsCoordinator.getExecutors()
            self.ordersCoordinator.getOrders()
            self.settingsCoordinator.getUserInfo()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == Defaults.tokenKey {
               getData()
           }
       }
}

extension CustomerTabBarController: UserImageDelegate {
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.executorsCoordinator.setImage(image)
            self.settingsCoordinator.setImage(image)
        }
    }
}
