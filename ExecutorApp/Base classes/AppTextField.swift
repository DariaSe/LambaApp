//
//  AppTextField.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 28.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AppTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        setHeight(equalTo: SizeConstants.textFieldHeight)
        backgroundColor = UIColor.textControlsBackgroundColor
        setLeftPaddingPoints(10)
        
        layer.cornerRadius = SizeConstants.textFieldCornerRadius
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.textControlsBackgroundColor.cgColor
        
        autocorrectionType = .no
        autocapitalizationType = .none
        clearButtonMode = .whileEditing
        returnKeyType = .done
    }
}
