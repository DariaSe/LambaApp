//
//  OrderSettingsTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 28.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderSettingsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderSettingsCell"
    
    private let stackView = UIStackView()
    
    private let labelSwitchStackView = UIStackView()
    private let titleLabel = UILabel()
    private let optionSwitch = AppSwitch()
    
    private let priceStackView = UIStackView()
    private let priceLabel = UILabel()
    private let separatorView = UIView()
    private let priceTextField = AppTextField()
    private let currencyLabel = UILabel()
    
    var switchIsOn: ((Bool) -> Void)?
    
    var textChanged: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: contentView, constant: 10)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.addArrangedSubview(labelSwitchStackView)
        stackView.addArrangedSubview(priceStackView)
        
        labelSwitchStackView.axis = .horizontal
        labelSwitchStackView.setWidth(equalTo: stackView)
        labelSwitchStackView.addArrangedSubview(titleLabel)
        labelSwitchStackView.addArrangedSubview(optionSwitch)
        
        priceStackView.axis = .horizontal
        priceStackView.alignment = .center
        priceStackView.distribution = .equalSpacing
        priceStackView.setWidth(equalTo: stackView, multiplier: 0.7)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(separatorView)
        priceStackView.addArrangedSubview(priceTextField)
        priceStackView.addArrangedSubview(currencyLabel)
        
        titleLabel.textAlignment = .left
        
        priceLabel.textAlignment = .left
        priceLabel.text = Strings.price
        
        separatorView.setWidth(equalTo: 1.0)
        separatorView.setHeight(equalTo: SizeConstants.textFieldHeight)
        separatorView.backgroundColor = UIColor.textControlsBackgroundColor
        
        priceTextField.delegate = self
        priceTextField.setHeight(equalTo: SizeConstants.textFieldHeight)
        priceTextField.setWidth(equalTo: 100)
        priceTextField.keyboardType = .numbersAndPunctuation
        priceTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        optionSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    func update(with settings: OrderSettings) {
        titleLabel.text = settings.title
        optionSwitch.isOn = settings.isOn
        priceTextField.text = settings.price
        currencyLabel.text = settings.currency
    }
    
    func updateReceiveOrders(isOn: Bool) {
        titleLabel.text = Strings.receiveOrders
        optionSwitch.isOn = isOn
        priceStackView.isHidden = true
    }
    
    @objc func switchValueChanged() {
        switchIsOn?(optionSwitch.isOn)
    }
    
    @objc func textFieldChanged() {
        textChanged?(priceTextField.text ?? "")
    }
    
    func isTextFieldValid() -> Bool {
        if let text = priceTextField.text, !text.isEmpty, Int(text) != nil {
            return true
        }
        else {
            return false
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        priceStackView.isHidden = false
    }
}

extension OrderSettingsTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setNormalBorder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if optionSwitch.isOn && !isTextFieldValid() {
            textField.shake()
            textField.setRedBorder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return false
    }
}
