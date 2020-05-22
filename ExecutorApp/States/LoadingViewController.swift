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
    
    convenience init(backgroundColor: UIColor) {
        self.init()
        view.backgroundColor = backgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        activityIndicator.center(in: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            self.activityIndicator.startAnimating()
        }
    }
}
