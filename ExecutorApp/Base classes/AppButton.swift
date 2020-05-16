//
//  AppButton.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    var isDestructive: Bool = false {
        didSet {
            setup()
        }
    }
    
    var color: UIColor { isDestructive ? UIColor.destructiveColor : UIColor.tintColor }
    
    var isSolid: Bool = true {
        didSet {
            setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow(height: 2, shadowRadius: 3, opacity: 0.1, cornerRadius: 12)
    }
    
    
    func setup() {
        layer.cornerRadius = SizeConstants.buttonCornerRadius
        layer.borderWidth = 1.0
        layer.borderColor = color.cgColor
        if isSolid {
            setTitleColor(UIColor.white, for: .normal)
            backgroundColor = color
        }
        else {
            setTitleColor(color, for: .normal)
            backgroundColor = UIColor.backgroundColor
        }
    }
}
