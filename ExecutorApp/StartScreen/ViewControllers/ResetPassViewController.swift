//
//  ResetPassViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ResetPassViewController: InputFormViewController {
    
    weak var coordinator: ForgotPassCoordinator?
    
    var email: String?
    
    let codeTextField = FormTextField(type: .code, placeholder: Strings.enterCode)
    
    let passwordTextField = FormTextField(type: .password, placeholder: Strings.newPassword)
    let confirmTextField = FormTextField(type: .password, placeholder: Strings.confirmPass)
    
    let resetButton = AppButton(title: Strings.resetPassword)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(codeTextField)
        add(passwordTextField)
        add(confirmTextField)
        add(resetButton)
        
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func resetButtonPressed() {
        view.endEditing(true)
        resetButton.animate(scale: 1.05)
        guard
            let email = email,
            let code = codeTextField.text,
            let password = passwordTextField.text,
            let confirmedPassword = confirmTextField.text,
            !code.isEmpty,
            !password.isEmpty,
            !confirmedPassword.isEmpty else {
                return
        }
        coordinator?.sendCodeAndPassword(code: code, email: email, password: password, confirmedPassword: confirmedPassword)
    }
    
}
