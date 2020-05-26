//
//  CustomerImageButton.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerImageButton: UIButton {
    
    private let stackView = UIStackView()
    private let buttonImageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: self)
        stackView.isUserInteractionEnabled = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(buttonImageView)
        stackView.addArrangedSubview(label)
        
        buttonImageView.isUserInteractionEnabled = false
        buttonImageView.setSize(width: 128, height: 128)
        buttonImageView.layer.cornerRadius = 64
        buttonImageView.clipsToBounds = true
        buttonImageView.contentMode = .scaleAspectFill
        buttonImageView.image = InfoService.shared.placeholderImage
        
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.textColor = UIColor.tintColor
        label.text = Strings.changePhoto
        label.font = UIFont.systemFont(ofSize: 16)
    }
    
    func setImage(_ image: UIImage?) {
        buttonImageView.image = image
    }
}
