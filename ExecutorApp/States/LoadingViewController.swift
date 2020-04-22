//
//  LoadingViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center(in: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
}
