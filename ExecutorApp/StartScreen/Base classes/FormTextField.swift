//
//  FormTextField.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class FormTextField: AppTextField {

    convenience init(type: FormTextFieldType, placeholder: String) {
        self.init()
        self.placeholder = placeholder
        switch type {
        case .email:
            keyboardType = .emailAddress
        case .password:
            isSecureTextEntry = true
        default:
            keyboardType = .decimalPad
        }
    }
}

enum FormTextFieldType {
    case email
    case password
    case code
}
