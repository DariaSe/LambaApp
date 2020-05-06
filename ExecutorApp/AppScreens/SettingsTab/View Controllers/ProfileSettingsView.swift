//
//  ProfileSettingsView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ProfileSettingsView: UIView {
    
    var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else { return }
            imageView.image = userInfo.image
            
            socialMediaTableView.setHeight(equalTo: CGFloat(userInfo.socialMedia.count * 80))
            socialMediaTableView.socialMedia = userInfo.socialMedia
            
            hashtagsView.hashtags = userInfo.hashtags
        }
    }
    
    var scrollView = UIScrollView()
    
    private let stackView = UIStackView()
    
    let imageView = UIImageView()
    private let changePhotoButton = UIButton()

    let socialMediaTableView = SocialMediaTableView()
    let hashtagsView = HashtagsView()
    
    private let changePasswordButton = AppButton()
    
    private let logoutButton = AppButton()
    
    var changePhoto: (() -> Void)?
    var changePassword: (() -> Void)?
    var logout: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        scrollView.pinToEdges(to: self)
        scrollView.setWidth(equalTo: self)
        stackView.pinToEdges(to: scrollView)
        stackView.setWidth(equalTo: scrollView)
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(socialMediaTableView)
        stackView.addArrangedSubview(hashtagsView)
        stackView.addArrangedSubview(changePasswordButton)
        stackView.addArrangedSubview(logoutButton)
        
        imageView.image = UIImage(named: "Portrait_Placeholder")
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setWidth(equalTo: self)
        
        self.addSubview(changePhotoButton)
        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        changePhotoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        changePhotoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        changePhotoButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10).isActive = true
        changePhotoButton.setTitle(Strings.changePhoto, for: .normal)
        changePhotoButton.setTitleColor(UIColor.white, for: .normal)
        changePhotoButton.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        changePhotoButton.isUserInteractionEnabled = true
        changePhotoButton.showsTouchWhenHighlighted = true
        
        socialMediaTableView.setWidth(equalTo: self, multiplier: 0.9)
        
        hashtagsView.setWidth(equalTo: stackView, multiplier: 0.9)
        
        changePasswordButton.setHeight(equalTo: SizeConstants.buttonHeight)
        changePasswordButton.setWidth(equalTo: self, multiplier: 0.9)
        changePasswordButton.setTitle(Strings.changePassword, for: .normal)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        
        logoutButton.isSolid = false
        logoutButton.setHeight(equalTo: SizeConstants.buttonHeight)
        logoutButton.setWidth(equalTo: self, multiplier: 0.9)
        logoutButton.setTitle(Strings.logout, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }
    
    @objc func changePhotoButtonPressed() {
        changePhotoButton.animate(scale: 1.1)
        changePhoto?()
    }
    
    @objc func changePasswordButtonPressed() {
        changePasswordButton.animate(scale: 1.05)
        changePassword?()
    }
    
    @objc func logoutButtonPressed() {
        logoutButton.animate(scale: 1.05)
        logout?()
    }
}

