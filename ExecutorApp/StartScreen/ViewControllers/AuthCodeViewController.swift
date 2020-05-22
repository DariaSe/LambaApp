//
//  AuthCodeViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AuthCodeViewController: InputFormViewController {
    
    weak var coordinator: ForgotPassCoordinator?
    
    let codeTextField = FormTextField(type: .code, placeholder: Strings.enterCode)
    let confirmButton = AppButton(title: Strings.send)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        add(codeTextField)
        add(confirmButton)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    
    @objc func confirmButtonPressed() {
        confirmButton.animate(scale: 1.05)
        view.endEditing(true)
        guard let code = codeTextField.text, !code.isEmpty else { return }
        coordinator?.sendAuthCode(code: code)
    }
}
