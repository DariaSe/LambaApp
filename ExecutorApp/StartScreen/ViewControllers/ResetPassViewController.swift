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
    
    let passwordTextField = FormTextField(type: .password, placeholder: Strings.newPassword)
    let confirmTextField = FormTextField(type: .password, placeholder: Strings.confirmPass)
    
    let resetButton = AppButton(title: Strings.resetPassword)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(passwordTextField)
        add(confirmTextField)
        add(resetButton)
        
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func resetButtonPressed() {
        view.endEditing(true)
        resetButton.animate(scale: 1.05)
        guard let password = passwordTextField.text, !password.isEmpty,
            let confirmedPassword = confirmTextField.text, !confirmedPassword.isEmpty else {
                return
        }
        coordinator?.sendPassword(old: password, new: confirmedPassword)
    }
    
}
