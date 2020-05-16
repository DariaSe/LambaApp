//
//  AppNavController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 16.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {
    override func viewDidLoad() {
        navigationBar.backgroundColor = UIColor.backgroundColor
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
    }
}
