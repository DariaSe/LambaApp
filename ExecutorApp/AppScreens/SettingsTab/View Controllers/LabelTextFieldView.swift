//
//  LabelTextFieldView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 27.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LabelTextFieldView: UIView {
    
    var title: String = "" {
        didSet {
            label.text = " " + title
        }
    }
    
    var text: String = "" {
        didSet {
            textField.text = text
        }
    }
    
    var textChanged: ((String) -> Void)?
    
    let stackView = UIStackView()
    let label = UILabel()
    let textField = FormTextField()
    
    var isTransparent: Bool = false {
        didSet {
            textField.backgroundColor = isTransparent ? UIColor.clear : UIColor.textControlsBackgroundColor
            textField.layer.borderColor = UIColor.clear.cgColor
            let separatorView = UIView()
            separatorView.constrainToEdges(of: self, leading: 0, trailing: 0, top: nil, bottom: 0)
            separatorView.setHeight(equalTo: 1)
            separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.12)
        }
    }
    
    convenience init(title: String, type: FormTextFieldType) {
        self.init()
        label.text = " " + title
        textField.type = type
    }
    
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
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        label.textAlignment = .left
        label.setHeight(equalTo: 16)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textColor.withAlphaComponent(0.8)
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    func isValid() -> Bool {
        if let text = textField.text, text.count >= 6 {
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

extension LabelTextFieldView: UITextFieldDelegate {
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
