//
//  LoginViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LoginViewController: InputFormViewController {
    
    weak var loginCoordinator: LoginCoordinator?
    
    weak var delegate: FormDelegate?
    
    let logoImageView = UIImageView()
    
    let signInWithGoogleButton = UIButton()
    
    let emailTextField = FormTextField(type: .email, placeholder: Strings.email)
    let passwordTextField = FormTextField(type: .password, placeholder: Strings.password)
    
    let loginButton = AppButton(title: Strings.login)
    let forgotPasswordButton = UIButton(title: Strings.forgotPassword)
    
    let registerButton = UIButton(title: Strings.register)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        initialSetup()
    }
  
    
    func initialSetup() {
        stackView.insertArrangedSubview(logoImageView, at: 0)
        stackView.insertArrangedSubview(signInWithGoogleButton, at: 1)
        add(emailTextField)
        add(passwordTextField)
        add(loginButton)
        add(forgotPasswordButton)
        
        addToBottom(registerButton)
        
        signInWithGoogleButton.setSize(width: 208, height: 50)
        signInWithGoogleButton.setImage(UIImage(named: "btn_google_signin_normal"), for: .normal)
        signInWithGoogleButton.setImage(UIImage(named: "btn_google_signin_pressed"), for: .highlighted)
        signInWithGoogleButton.addTarget(self, action: #selector(singInWithGoogleButtonPressed), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        forgotPasswordButton.setTitleColor(UIColor.tintColor, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
      
        registerButton.setTitleColor(UIColor.tintColor, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }
    
    @objc func singInWithGoogleButtonPressed() {
        signInWithGoogleButton.animate(scale: 1.05)
    }
    
    @objc func loginButtonPressed() {
        view.endEditing(true)
        loginButton.animate(scale: 1.05)
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        loginCoordinator?.login(email: email, password: password)
    }
    
    @objc func forgotPasswordButtonPressed() {
        view.endEditing(true)
        forgotPasswordButton.animate(scale: 1.05)
        delegate?.showForgotPassScreen()
    }
    
    @objc func registerButtonPressed() {
        view.endEditing(true)
        registerButton.animate(scale: 1.05)
        delegate?.showRegistrationScreen()
    }
    
    
    func restoreAppearance() {
        passwordTextField.text = ""
    }
}


