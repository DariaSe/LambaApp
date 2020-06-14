//
//  OrderFormTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderFormTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderFormCell"
    
    private let stackView = UIStackView()
  
    private let label = UILabel()
    private let textView = UITextView()
    private let placeholderLabel = UILabel()
    
    var textChanged: ((String) -> Void)?
    
    var isEditable: Bool = true {
        didSet {
            if isEditable {
                textView.backgroundColor = UIColor.textControlsBackgroundColor
                textView.isEditable = true
            }
            else {
                textView.backgroundColor = UIColor.clear
                textView.isEditable = false
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: contentView, constant: 7)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textView)
        
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        
        textView.layer.cornerRadius = SizeConstants.textFieldCornerRadius
        textView.backgroundColor = UIColor.textControlsBackgroundColor
        textView.setWidth(equalTo: stackView)
        textView.autocapitalizationType = .sentences
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.delegate = self
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10).isActive = true
        placeholderLabel.textColor = UIColor.placeholderTextColor
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func update(with unit: OrderSchemeUnit) {
        label.text = unit.title
        placeholderLabel.text = unit.placeholder
        placeholderLabel.isHidden = !unit.text.isEmpty
        textView.text = unit.text
        if unit.isRequired {
            let attrText = NSMutableAttributedString(string: label.text ?? "")
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.destructiveColor]
            let asterisk = NSAttributedString(string: "*", attributes: attributes)
            attrText.append(asterisk)
            label.attributedText = attrText
        }
    }
}

extension OrderFormTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            textView.text.removeLast()
            self.endEditing(true)
        }
        textChanged?(textView.text)
    }
}
