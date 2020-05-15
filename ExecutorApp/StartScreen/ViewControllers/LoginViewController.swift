//
//  LoginViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, KeyboardHandler {
    
    weak var loginCoordinator: LoginCoordinator?
   
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let textFieldsStackView = UIStackView()
    
//    let logoImageView = UIImageView()
    
    let emailTextField = AppTextField()
    let passwordTextField = AppTextField()
    
    let loginButton = AppButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications(for: scrollView)
        view.backgroundColor = UIColor.backgroundColor
        setupLayout()
        initialSetup()
    }
    
   
    func setupLayout() {
        scrollView.pinToEdges(to: view)
        scrollView.contentSize = CGSize(width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right, height: view.bounds.height - view.layoutMargins.top - view.layoutMargins.bottom)
        
        stackView.center(in: scrollView)
        stackView.setWidth(equalTo: view, multiplier: 0.8)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 40
        stackView.distribution = .equalSpacing
//        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(textFieldsStackView)
        stackView.addArrangedSubview(loginButton)
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .fill
        textFieldsStackView.spacing = 20
        textFieldsStackView.setWidth(equalTo: stackView)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
        emailTextField.setHeight(equalTo: SizeConstants.textFieldHeight)
        passwordTextField.setHeight(equalTo: emailTextField)
        
        loginButton.setWidth(equalTo: 100)
        loginButton.setHeight(equalTo: SizeConstants.buttonHeight)
    }
    
    func initialSetup() {
        
        emailTextField.delegate = self
        emailTextField.placeholder = Strings.email
        
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = Strings.password
        
        loginButton.setTitle(Strings.login, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        view.endEditing(true)
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.showInvalid()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else { passwordTextField.showInvalid()
            return
        }
        loginCoordinator?.login(email: email, password: password)
    }
    
    
    func restoreAppearance() {
        emailTextField.setNormalBorder()
        passwordTextField.setNormalBorder()
        passwordTextField.text = ""
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.setNormalBorder()
        passwordTextField.setNormalBorder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

