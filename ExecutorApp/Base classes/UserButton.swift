//
//  UserButton.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 16.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class UserButton: UIBarButtonItem {
    
    var userImage: UIImage? {
        didSet {
            button.setImage(userImage, for: .normal)
        }
    }
    
    var userTapped: (() -> Void)?
    
    let button = UIButton()
    
    override init() {
        super.init()
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).cgPath
        button.layer.mask = maskLayer
        button.setWidth(equalTo: 40)
        button.setHeight(equalTo: 40)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.setImage(UIImage(named: "Portrait_Placeholder"), for: .normal)
        customView = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func pressed() {
        userTapped?()
    }
}
