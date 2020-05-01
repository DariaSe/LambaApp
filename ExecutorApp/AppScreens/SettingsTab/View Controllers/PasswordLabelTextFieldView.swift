//
//  PasswordLabelTextFieldView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 27.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class PasswordLabelTextFieldView: UIView {
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    var textChanged: ((String) -> Void)?
    
    let stackView = UIStackView()
    let label = UILabel()
    let textField = AppTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: self)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        label.textAlignment = .left
        label.setHeight(equalTo: 16)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textColor.withAlphaComponent(0.8)
        
        textField.setHeight(equalTo: SizeConstants.textFieldHeight)
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    func isValid() -> Bool {
        if let text = textField.text, text.containsDigit(), text.count >= 6 {
            return true
        }
        else {
            return false
        }
    }
    
    @objc func editingChanged() {
        textChanged?(textField.text ?? "")
    }
    
}

extension PasswordLabelTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.textControlsBackgroundColor.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        return text.count + (string.count - range.length) <= 30
    }
    
}
