//
//  SocialMediaTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SocialMediaTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SocialMediaCell"
    
    private let stackView = UIStackView()
    private let socialMediaImageView = UIImageView()
    
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let textField = AppTextField()
    
    var textChanged: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.constrainToEdges(of: contentView, leading: 10, trailing: 0, top: 10, bottom: 10)
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.addArrangedSubview(socialMediaImageView)
        stackView.addArrangedSubview(textStackView)
        
        textStackView.axis = .vertical
        textStackView.distribution = .fill
        textStackView.spacing = 10
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(textField)
        
        socialMediaImageView.setWidth(equalTo: 30)
        socialMediaImageView.setHeight(equalTo: 30)
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.darkGray
        
        textField.delegate = self
        textField.setHeight(equalTo: SizeConstants.textFieldHeight)
        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
    }
    
    func update(with socialMedia: SocialMedia) {
        socialMediaImageView.image = socialMedia.image
        titleLabel.text = socialMedia.title
        textField.text = socialMedia.nickName
    }
    
    @objc func textFieldTextChanged() {
        textChanged?(textField.text ?? "")
    }
}

extension SocialMediaTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return false
    }
}
