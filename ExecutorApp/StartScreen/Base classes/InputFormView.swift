//
//  InputFormView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class InputFormView: UIView {
    
    private let stackView = UIStackView()
    
    private let textFieldsStackView = UIStackView()
    
    private let buttonsStackView = UIStackView()
    
    
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
        stackView.alignment = .center
        stackView.spacing = 40
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(textFieldsStackView)
        stackView.addArrangedSubview(buttonsStackView)
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .fill
        textFieldsStackView.spacing = 20
        textFieldsStackView.setWidth(equalTo: stackView)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.alignment = .fill
        buttonsStackView.spacing = 20
        buttonsStackView.setWidth(equalTo: stackView, multiplier: 0.8)
    }
    
    func add(textField: FormTextField) {
        textFieldsStackView.addArrangedSubview(textField)
        textField.delegate = self
    }
    
    func add(button: UIButton) {
        buttonsStackView.addArrangedSubview(button)
    }
}

extension InputFormView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}
