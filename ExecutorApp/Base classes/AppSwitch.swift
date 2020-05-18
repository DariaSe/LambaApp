//
//  AppSwitch.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 28.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AppSwitch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        onTintColor = UIColor.greenIndicatorColor
    }
}
