//
//  OrderStatusImageView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderStatusImageView: UIView {
    
    var status: OrderStatus? {
        didSet {
            guard let status = status else { return }
            switch status {
            case .done:
                imageView.image = UIImage(named: "Done")
                descrLabel.text = Strings.statusDone
                descrLabel.textColor = UIColor.greenIndicatorColor
                openVideoButton.isHidden = false

            case .rejectedExecutor:
                imageView.image = UIImage(named: "Cancelled")
                descrLabel.text = Strings.youRejected
                descrLabel.textColor = UIColor.redIndicatorColor
                openVideoButton.isHidden = true
                
            case .rejectedCustomer:
                break

            case .uploading:
                imageView.image = UIImage(named: "Uploading")
                descrLabel.text = Strings.videoUploading
                descrLabel.textColor = UIColor.gray
                openVideoButton.isHidden = true
                
            case .active:
                break
            }
        }
    }
    
    private let stackView = UIStackView()
    
    private let imageView = UIImageView()
    private let descrLabel = UILabel()
    
    private let openVideoButton = AppButton()
    
    var openVideo: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: self)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descrLabel)
        stackView.addArrangedSubview(openVideoButton)
        
        imageView.setWidth(equalTo: 80)
        imageView.setHeight(equalTo: 80)
        
        descrLabel.font = UIFont.systemFont(ofSize: 12)
        
        openVideoButton.setTitle(Strings.openVideo, for: .normal)
        openVideoButton.setWidth(equalTo: self, multiplier: 0.7)
        openVideoButton.addTarget(self, action: #selector(openVideoButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func openVideoButtonPressed() {
           openVideoButton.animate(scale: 1.05)
           openVideo?()
       }
}
