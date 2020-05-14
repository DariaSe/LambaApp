//
//  HashtagsView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 28.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class HashtagsView: UIView {
    
    var hashtags: [String] = [] {
        didSet {
            textView.text = hashtags.joined(separator: " ")
            if !hashtags.isEmpty {
                placeholderLabel.isHidden = true
            }
        }
    }
    
    var hashtagsChanged: (() -> Void)?
    
    var delegate: SettingsDelegate?
    
    private let stackView = UIStackView()
    
    private let label = UILabel()
    let textView = UITextView()
    private let placeholderLabel = UILabel()
    
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
        stackView.addArrangedSubview(textView)
        
        label.textAlignment = .left
        label.text = Strings.listHashtags
        label.font = UIFont.systemFont(ofSize: 12)
        
        textView.layer.cornerRadius = SizeConstants.textFieldCornerRadius
        textView.backgroundColor = UIColor.textControlsBackgroundColor
        textView.setHeight(equalTo: SizeConstants.textFieldHeight * 3)
        textView.setWidth(equalTo: self)
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10).isActive = true
        placeholderLabel.textColor = UIColor.placeholderTextColor
        placeholderLabel.font = UIFont.systemFont(ofSize: 12)
        placeholderLabel.text = Strings.hashtagPlaceholder
    }
}

extension HashtagsView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        }
        else {
            placeholderLabel.isHidden = true
        }
        guard let text = textView.text else { return }
        let tags = text.components(separatedBy: " ")
        hashtags = tags
        if hashtags.last == "" {
            hashtags.removeLast()
        }
        delegate?.sendChanges()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            textView.text.removeLast()
            self.endEditing(true)
        }
    }
}
