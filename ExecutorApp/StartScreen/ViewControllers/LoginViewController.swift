//
//  LoginViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, KeyboardHandler {
   
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
        scrollView.pinToLayoutMargins(to: view)
        scrollView.isScrollEnabled = true
        
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
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center(in: view)
        activityIndicator.startAnimating()
        LoginService.login(email: email, password: password) { [weak self] (token, errorMessage) in
            if let token = token {
                Defaults.token = token
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self?.dismiss(animated: true, completion: nil)
                }
            }
            else if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self?.showLoginFailed(message: errorMessage)
                }
            }
        }
    }
    
    func showLoginFailed(message: String) {
        let alert = UIAlertController(title: Strings.loginFailed, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            self?.restoreAppearance()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
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
