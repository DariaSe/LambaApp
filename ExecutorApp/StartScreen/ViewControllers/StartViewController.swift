//
//  StartViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    let label = UILabel()
    
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        label.centerInSafeArea(in: view)
        label.text = "App logo here"
        label.font = UIFont.systemFont(ofSize: 24)
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
}
