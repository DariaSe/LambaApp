//
//  e_UITextField.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UITextField {
    
    func showInvalid() {
        setRedBorder()
        shake()
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UITextField {
    func setGreenBorder() {
        layer.borderColor = UIColor.greenIndicatorColor.cgColor
    }
    
    func setRedBorder() {
        layer.borderColor = UIColor.destructiveColor.cgColor
    }
    
    func setNormalBorder() {
        layer.borderColor = UIColor.textControlsBackgroundColor.cgColor
    }
}
