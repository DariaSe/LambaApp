//
//  ChangePasswordViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 27.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, KeyboardHandler {
   
    var changePassword: ((PassInfo) -> Void)?
    
    private let scrollView = UIScrollView()
    
    private let stackView = UIStackView()
    
    private let unitsStackView = UIStackView()
    private let oldPassUnit = PasswordLabelTextFieldView()
    private let newPassUnit = PasswordLabelTextFieldView()
    private let confirmNewPassUnit = PasswordLabelTextFieldView()
    private let reqiurementsLabel = UILabel()
    
    private let buttonsStackView = UIStackView()
    private let doneButton = AppButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications(for: scrollView)
        view.backgroundColor = UIColor.backgroundColor
        scrollView.pinTopAndBottomToLayoutMargins(to: view)
        stackView.pinToLayoutMargins(to: scrollView, constant: 10)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(unitsStackView)
        
        unitsStackView.axis = .vertical
        unitsStackView.spacing = 20
        unitsStackView.alignment = .fill
        unitsStackView.distribution = .fillEqually
        unitsStackView.addArrangedSubview(oldPassUnit)
        unitsStackView.addArrangedSubview(newPassUnit)
        unitsStackView.addArrangedSubview(confirmNewPassUnit)
        unitsStackView.addArrangedSubview(reqiurementsLabel)
        
        oldPassUnit.title = Strings.oldPassword
        newPassUnit.title = Strings.newPassword
        confirmNewPassUnit.title = Strings.confirmNewPass
        confirmNewPassUnit.textChanged = { [weak self] text in
            guard !text.isEmpty else { return }
            if text == self?.newPassUnit.textField.text {
                self?.confirmNewPassUnit.textField.setGreenBorder()
            }
            else {
                self?.confirmNewPassUnit.textField.setRedBorder()
            }
        }
        
        reqiurementsLabel.textAlignment = .left
        reqiurementsLabel.text = Strings.passReqiurements
        reqiurementsLabel.numberOfLines = 0
        reqiurementsLabel.font = UIFont.systemFont(ofSize: 14)
        
        stackView.addArrangedSubview(doneButton)
        
        doneButton.setHeight(equalTo: SizeConstants.buttonHeight)
        doneButton.setTitle(Strings.changePassword, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)

    }
    
    @objc func doneButtonPressed() {
        doneButton.animate(scale: 1.05)
        view.endEditing(true)
        if areTextFieldsValid() {
            let passInfo = PassInfo(oldPass: oldPassUnit.textField.text!, newPass: newPassUnit.textField.text!, confirmNewPass: confirmNewPassUnit.textField.text!)
            changePassword?(passInfo)
        }
        else {
            let alert = UIAlertController(title: Strings.passReqiurements, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                self?.clearTextFields()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func areTextFieldsValid() -> Bool {
        if oldPassUnit.isValid(), newPassUnit.isValid(), confirmNewPassUnit.isValid(), newPassUnit.textField.text == confirmNewPassUnit.textField.text {
            return true
        }
        else {
            return false
        }
    }
    
    func clearTextFields() {
        oldPassUnit.textField.text = ""
        newPassUnit.textField.text = ""
        confirmNewPassUnit.textField.text = ""
        confirmNewPassUnit.textField.setNormalBorder()
    }
   

}
