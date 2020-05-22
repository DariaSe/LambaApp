//
//  RegistrationViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class RegistrationViewController: InputFormViewController {
    
    weak var coordinator: RegistrationCoordinator?
    
    let emailTextField = FormTextField(type: .email, placeholder: Strings.email)
    let passwordTextField = FormTextField(type: .password, placeholder: Strings.password)
    let confirmTextField = FormTextField(type: .password, placeholder: Strings.confirmPass)
    
    let registerButton = AppButton(title: Strings.register)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(emailTextField)
        add(passwordTextField)
        add(confirmTextField)
        add(registerButton)
      
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }
    
    @objc func registerButtonPressed() {
        view.endEditing(true)
        registerButton.animate(scale: 1.05)
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let confirmedPassword = confirmTextField.text, !confirmedPassword.isEmpty else {
                return
        }
        coordinator?.register(email: email, password: password, confirmedPassword: confirmedPassword)
    }
}


