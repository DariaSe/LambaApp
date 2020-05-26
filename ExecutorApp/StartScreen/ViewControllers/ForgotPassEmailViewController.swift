//
//  ForgotPassEmailViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ForgotPassEmailViewController: InputFormViewController {
    
    weak var coordinator: ForgotPassCoordinator?
    
    var email: String? {
        didSet {
            emailTextField.text = email
        }
    }
    
    let emailTextField = FormTextField(type: .email, placeholder: Strings.email)
 
    let sendCodeButton = AppButton(title: Strings.sendAuthCode)
    let haveCodeButton = UIButton(title: Strings.haveCode)

    override func viewDidLoad() {
        super.viewDidLoad()
        add(emailTextField)
        add(sendCodeButton)
        add(haveCodeButton)
        sendCodeButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        haveCodeButton.setTitleColor(UIColor.tintColor, for: .normal)
        haveCodeButton.addTarget(self, action: #selector(haveCodeButtonPressed), for: .touchUpInside)
    }
   
    @objc func resetButtonPressed() {
        view.endEditing(true)
        sendCodeButton.animate(scale: 1.05)
        guard let email = emailTextField.text, !email.isEmpty else {
            coordinator?.showSimpleAlert(title: Strings.enterEmail, handler: nil)
            return
        }
        coordinator?.requestAuthCode(email: email)
    }
    
    @objc func haveCodeButtonPressed() {
        view.endEditing(true)
        haveCodeButton.animate(scale: 1.05)
        guard let email = emailTextField.text, !email.isEmpty else {
            coordinator?.showSimpleAlert(title: Strings.enterEmail, handler: nil)
            return
        }
        coordinator?.showResetPassScreen(email: email)
    }
}
