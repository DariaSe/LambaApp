//
//  OrderStatusButtonsView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderStatusButtonsView: UIView {
    
    private let stackView = UIStackView()
    
    private let uploadButton = AppButton()
    private let rejectButton = AppButton()
    
    var uploadOptions: (() -> Void)?
    var reject: (() -> Void)?
    
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
        stackView.addArrangedSubview(uploadButton)
        stackView.addArrangedSubview(rejectButton)
        
        uploadButton.setTitle(Strings.openCamera, for: .normal)
        uploadButton.setHeight(equalTo: SizeConstants.buttonHeight)
        uploadButton.setWidth(equalTo: self)
        uploadButton.addTarget(self, action: #selector(uploadButtonPressed), for: .touchUpInside)
        
        rejectButton.setTitle(Strings.reject, for: .normal)
        rejectButton.isDestructive = true
        rejectButton.setHeight(equalTo: SizeConstants.buttonHeight)
        rejectButton.setWidth(equalTo: self)
        rejectButton.addTarget(self, action: #selector(rejectButtonPressed), for: .touchUpInside)
    }
    
    @objc func uploadButtonPressed() {
        uploadButton.animate(scale: 1.05)
        uploadOptions?()
    }
   
    @objc func rejectButtonPressed() {
        rejectButton.animate(scale: 1.05)
        reject?()
    }
}
