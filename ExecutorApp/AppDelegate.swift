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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Defaults.setDefault()
        
        var rootVC: UIViewController
        
        if Defaults.hasToken {
            rootVC = BiometricAuthViewController()
        }
        else {
//            rootVC = LoginViewController()
            rootVC = MainTabBarController()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        return true
    }

   
}

