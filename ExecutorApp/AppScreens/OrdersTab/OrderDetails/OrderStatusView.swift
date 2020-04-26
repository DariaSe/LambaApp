//
//  OrderStatusView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderStatusView: UIView {
    
    var status: OrderStatus? {
        didSet {
            guard let status = status else { return }
            switch status {
            case .done:
                imageView.isHidden = false
                descrLabel.isHidden = false
                imageView.image = UIImage(named: "Done")
                descrLabel.text = Strings.done
                descrLabel.textColor = UIColor.greenIndicatorColor
                openCameraButton.isHidden = true
                rejectButton.isHidden = true
            case .todo:
                imageView.isHidden = true
                descrLabel.isHidden = true
                openCameraButton.isHidden = false
                rejectButton.isHidden = false
            case .rejected:
                imageView.isHidden = false
                descrLabel.isHidden = false
                imageView.image = UIImage(named: "Cancelled")
                descrLabel.text = Strings.youRejected
                descrLabel.textColor = UIColor.redIndicatorColor
                openCameraButton.isHidden = true
                rejectButton.isHidden = true
            case .uploading:
                break
            }
        }
    }
    
    var openCamera: (() -> Void)?
    var reject: (() -> Void)?
    
    private let stackView = UIStackView()
    
    private let imageView = UIImageView()
    private let descrLabel = UILabel()
    
    private let openCameraButton = AppButton()
    private let rejectButton = AppButton()
    
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
        stackView.addArrangedSubview(openCameraButton)
        stackView.addArrangedSubview(rejectButton)
        
        imageView.setWidth(equalTo: 80)
        imageView.setHeight(equalTo: 80)
        
        descrLabel.font = UIFont.systemFont(ofSize: 12)
        
        openCameraButton.setTitle(Strings.openCamera, for: .normal)
        openCameraButton.setHeight(equalTo: 40)
        openCameraButton.setWidth(equalTo: self)
        openCameraButton.addTarget(self, action: #selector(openCameraButtonPressed), for: .touchUpInside)
        
        rejectButton.setTitle(Strings.reject, for: .normal)
        rejectButton.isDestructive = true
        rejectButton.setHeight(equalTo: 40)
        rejectButton.setWidth(equalTo: self)
        rejectButton.addTarget(self, action: #selector(rejectButtonPressed), for: .touchUpInside)
    }
    
    @objc func openCameraButtonPressed() {
        openCameraButton.animate(scale: 1.05)
        openCamera?()
    }
    
    @objc func rejectButtonPressed() {
        rejectButton.animate(scale: 1.05)
        reject?()
    }
    
}
