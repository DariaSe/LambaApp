//
//  CustomerSettingsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerSettingsViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: CustomerSettingsCoordinator?
    
    var userInfo: CustomerUserInfo? {
        didSet {
            guard let userInfo = userInfo else { return }
            refreshControl.endRefreshing()
            nameUnit.text = userInfo.firstName
            lastNameUnit.text = userInfo.lastName
            emailUnit.text = userInfo.email
        }
    }
    
    private let scrollView = UIScrollView()
    
    private let stackView = UIStackView()
    
    private let imageButton = CustomerImageButton()
    
    private let textFieldsStackView = UIStackView()
    private let nameUnit = LabelTextFieldView(title: Strings.name, type: .text)
    private let lastNameUnit = LabelTextFieldView(title: Strings.lastName, type: .text)
    private let emailUnit = LabelTextFieldView(title: Strings.email, type: .email)
    
    private let buttonsStackView = UIStackView()
    private let changePassButton = AppButton(title: Strings.changePassword)
    private let logoutButton = AppButton(title: Strings.logout)
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setupLayout()
        initialSetup()
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications(for: scrollView)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        coordinator?.getUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sendChanges()
    }
    
    func scrollToTop() {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func setupLayout() {
        scrollView.pinTopAndBottomToLayoutMargins(to: view)
        scrollView.setWidth(equalTo: view)
        stackView.constrainToEdges(of: scrollView, leading: 0, trailing: 0, top: 20, bottom: 30)
        stackView.setWidth(equalTo: scrollView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        
        stackView.addArrangedSubview(imageButton)
        stackView.addArrangedSubview(textFieldsStackView)
        stackView.addArrangedSubview(buttonsStackView)
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 15
        textFieldsStackView.setWidth(equalTo: view, multiplier: 0.9)
        textFieldsStackView.addArrangedSubview(nameUnit)
        textFieldsStackView.addArrangedSubview(lastNameUnit)
        textFieldsStackView.addArrangedSubview(emailUnit)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 12
        buttonsStackView.setWidth(equalTo: view, multiplier: 0.9)
        buttonsStackView.addArrangedSubview(changePassButton)
        buttonsStackView.addArrangedSubview(logoutButton)
        
    }
    
    func initialSetup() {
        nameUnit.textField.delegate = self
        lastNameUnit.textField.delegate = self
        emailUnit.textField.delegate = self
        
        nameUnit.isTransparent = true
        lastNameUnit.isTransparent = true
        emailUnit.isTransparent = true
        
        imageButton.addTarget(self, action: #selector(imageButtonPressed), for: .touchUpInside)
        changePassButton.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        logoutButton.isSolid = false
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func imageButtonPressed() {
        imageButton.animate(scale: 1.05)
        coordinator?.showPhotoPicker()
    }
    
    func setImage(_ image: UIImage?) {
        imageButton.setImage(image)
    }
    
    @objc func changePasswordButtonPressed() {
        changePassButton.animate(scale: 1.05)
        coordinator?.showChangePasswordScreen()
    }
    
    @objc func logoutButtonPressed() {
        logoutButton.animate(scale: 1.05)
        coordinator?.logout()
    }
    
    func sendChanges() {
        guard
            let firstName = nameUnit.textField.text,
            let lastName = lastNameUnit.textField.text,
            let email = emailUnit.textField.text
            else { return }
        let newUserInfo = CustomerUserInfo(firstName: firstName, lastName: lastName, email: email)
        if userInfo != newUserInfo {
            self.userInfo = newUserInfo
            coordinator?.postUserInfo(newUserInfo)
        }
    }
}

extension CustomerSettingsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailUnit.textField {
            coordinator?.showChangeEmailModal()
            view.endEditing(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        sendChanges()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
