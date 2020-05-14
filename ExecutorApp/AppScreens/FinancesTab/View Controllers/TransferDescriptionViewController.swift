//
//  TransferDescriptionViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class TransferDescriptionViewController: UIViewController {
    
    var text: String = "" {
        didSet {
            infoLabel.text = text
        }
    }
    
    private let containerView = UIView()
    
    private let stackView = UIStackView()
    
    private let infoLabel = UILabel()
    private let okButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.pinToEdges(to: view)
        
        containerView.center(in: view)
        containerView.setWidth(equalTo: view, multiplier: 0.9)
        containerView.setHeight(equalTo: view, multiplier: 0.7)
        containerView.backgroundColor = UIColor.backgroundColor
        containerView.layer.cornerRadius = SizeConstants.textFieldCornerRadius
        
        stackView.pinToLayoutMargins(to: containerView)
        stackView.axis = .vertical
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(okButton)
        
        infoLabel.numberOfLines = 0
        
        okButton.setHeight(equalTo: SizeConstants.buttonHeight)
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func okButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
