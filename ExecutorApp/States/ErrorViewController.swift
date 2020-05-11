//
//  ErrorViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    var message: String = Strings.error.localized {
        didSet {
            errorLabel.text = message
        }
    }
    
    var reload: (() -> Void)?
    
    private let stackView = UIStackView()
    
    private let errorLabel = UILabel()
    let reloadButton = AppButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        stackView.center(in: view)
        stackView.setWidth(equalTo: view, multiplier: 0.8)
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .center
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(reloadButton)
        
        errorLabel.text = message
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        
        reloadButton.setTitle(Strings.tryAgain, for: .normal)
        reloadButton.setWidth(equalTo: 200)
        reloadButton.setHeight(equalTo: SizeConstants.buttonHeight)
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func reloadButtonTapped() {
        reloadButton.animate(scale: 1.05)
        reload?()
    }
}
