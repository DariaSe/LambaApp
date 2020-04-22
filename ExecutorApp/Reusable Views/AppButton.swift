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
            backgroundColor = color
        }
    }
    
    var color: UIColor { isDestructive ? UIColor.destructiveColor : UIColor.tintColor }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialSetup() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = color
        layer.cornerRadius = 12
    }
}
