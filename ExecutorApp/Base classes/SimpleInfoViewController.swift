//
//  SimpleInfoViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SimpleInfoViewController: UIViewController {
    
    var text: String = "" {
        didSet {
            infoTextView.text = text
            let textHeight = text.height(withConstrainedWidth: view.bounds.width * 0.9 - 20, font: UIFont.systemFont(ofSize: 18)) + 40
            infoTextViewHeightConstraint.constant = min(textHeight, maxHeight)
        }
    }
    
    private let containerView = UIView()
    
    private let stackView = UIStackView()
    
    private let infoTextView = UITextView()
    private let okButton = AppButton()
    
    lazy var maxHeight: CGFloat = { return view.bounds.height * 0.7 }()
    var infoTextViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.pinToEdges(to: view)
        
        containerView.center(in: view)
        containerView.setWidth(equalTo: view, multiplier: 0.9)
//        containerView.setHeight(equalTo: view, multiplier: 0.7)
        containerView.backgroundColor = UIColor.backgroundColor
        containerView.layer.cornerRadius = SizeConstants.textFieldCornerRadius
        containerView.dropShadow(height: 2, shadowRadius: 1, opacity: 0.1, cornerRadius: SizeConstants.textFieldCornerRadius)
        
        stackView.pinToLayoutMargins(to: containerView)
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.addArrangedSubview(infoTextView)
        stackView.addArrangedSubview(okButton)
        
        infoTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        infoTextView.isEditable = false
        infoTextView.font = UIFont.systemFont(ofSize: 18)
        infoTextViewHeightConstraint = infoTextView.heightAnchor.constraint(equalToConstant: 0)
        infoTextViewHeightConstraint.isActive = true

        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func okButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
