//
//  FormTextField.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class FormTextField: AppTextField {
    
    var type: FormTextFieldType = .text {
        didSet {
            setKeyboardType(for: type)
        }
    }
    
    convenience init(type: FormTextFieldType, placeholder: String) {
        self.init()
        self.placeholder = placeholder
        setKeyboardType(for: type)
    }
    
    func setKeyboardType(for type: FormTextFieldType) {
        switch type {
        case .text:
            keyboardType = .default
        case .email:
            keyboardType = .emailAddress
        case .password:
            isSecureTextEntry = true
        case .code:
            keyboardType = .decimalPad
            
        }
    }
}

enum FormTextFieldType {
    case text
    case email
    case password
    case code
}
