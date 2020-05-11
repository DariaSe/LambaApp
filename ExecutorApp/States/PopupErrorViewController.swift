//
//  PopupErrorViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//
import UIKit

class PopupErrorViewController: UIViewController {
    
    let errorContainerView = UIView()
    let errorLabel = UILabel()
    
    convenience init(message: String) {
        self.init()
        errorLabel.text = message
    }
    var message: String = "" {
        didSet {
            errorLabel.text = self.message
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        errorContainerView.center(in: view)
        errorContainerView.setWidth(equalTo: view, multiplier: 0.9)
        errorContainerView.setHeight(equalTo: 160)
        errorContainerView.backgroundColor = UIColor.backgroundColor
        errorContainerView.layer.cornerRadius = 15
        errorContainerView.layer.shadowRadius = 6

        errorContainerView.alpha = 0.0
        
        errorLabel.pinToLayoutMargins(to: errorContainerView)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.errorContainerView.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 3.0, options: [], animations: {
                self.errorContainerView.alpha = 0.0
            }) { (_) in
                self.remove()
            }
        }
    }
    

}
