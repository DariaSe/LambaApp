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
            infoTextView.text = text
        }
    }
    
    private let containerView = UIView()
    
    private let stackView = UIStackView()
    
    private let infoTextView = UITextView()
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
        containerView.dropShadow(height: 2, shadowRadius: 1, opacity: 0.1, cornerRadius: SizeConstants.textFieldCornerRadius)
        
        stackView.pinToLayoutMargins(to: containerView)
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.addArrangedSubview(infoTextView)
        stackView.addArrangedSubview(okButton)
        
        infoTextView.isEditable = false
        infoTextView.font = UIFont.systemFont(ofSize: 16)

        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func okButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
