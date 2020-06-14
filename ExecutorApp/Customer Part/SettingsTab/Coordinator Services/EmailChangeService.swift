//
//  EmailChangeService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 14.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class EmailChangeService {
    
    static func alert(handler: @escaping (_ code: String, _ newEmail: String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: Strings.authCodeSent, message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: Strings.save, style: .default) { (_) in
            if let codeTextField = alertController.textFields?[0],
                let code = codeTextField.text,
                let newEmailTextField = alertController.textFields?[1],
                let newEmail = newEmailTextField.text {
                handler(code, newEmail)
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { (codeTextField) in
            codeTextField.setHeight(equalTo: SizeConstants.textFieldHeight)
            codeTextField.placeholder = Strings.enterCode
            codeTextField.font = UIFont.systemFont(ofSize: 16)
            codeTextField.layer.cornerRadius = SizeConstants.textFieldCornerRadius
        }
        alertController.addTextField { (newEmailTextField) in
            newEmailTextField.setHeight(equalTo: SizeConstants.textFieldHeight)
            newEmailTextField.keyboardType = .emailAddress
            newEmailTextField.placeholder = Strings.newEmail
            newEmailTextField.font = UIFont.systemFont(ofSize: 16)
            newEmailTextField.layer.cornerRadius = SizeConstants.textFieldCornerRadius
        }
        alertController.view.setHeight(equalTo: 250)
        return alertController
    }
}
