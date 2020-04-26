//
//  EmptyViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {
    
    convenience init(message: String) {
        self.init()
        label.text = message
    }
    
    var canReload: Bool = true
    
    var reload: (() -> Void)?
    
    private let stackView = UIStackView()
    
    private let label = UILabel()
    private let reloadButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        stackView.center(in: view)
        stackView.setWidth(equalTo: view, multiplier: 0.8)
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
        if canReload {
            stackView.addArrangedSubview(reloadButton)
        }
        
        label.text = Strings.noOrdersYet
        label.textAlignment = .center
        
        reloadButton.setTitle(Strings.tryAgain, for: .normal)
        reloadButton.setWidth(equalTo: 100)
        reloadButton.setHeight(equalTo: 40)
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func reloadButtonTapped() {
        reload?()
    }
}
