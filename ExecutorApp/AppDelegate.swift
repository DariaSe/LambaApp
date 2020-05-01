//
//  AppDelegate.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let startCoordinator = StartCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Defaults.setDefault()
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startCoordinator.mainVC
        window?.makeKeyAndVisible()
        startCoordinator.start()

        return true
    }

   
}

