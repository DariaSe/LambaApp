//
//  NoPasteTextField.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 10.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class NoPasteTextField: AppTextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
           return action != #selector(UIResponderStandardEditActions.paste(_:))
       }
}
