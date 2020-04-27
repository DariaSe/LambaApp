//
//  LabelTextFieldView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 27.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LabelTextFieldView: UIView {
    
    var text: String = ""
    
    private let stackView = UIStackView()
    private let label = UILabel()
    private let textField = UITextField()

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
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textColor.withAlphaComponent(0.8)
        
        textField.setHeight(equalTo: 30)
        textField.setLeftPaddingPoints(10)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.delegate = self
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
    }

}

extension LabelTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.textControlsBackgroundColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text = textField.text ?? ""
        self.endEditing(true)
        return false
    }
}
