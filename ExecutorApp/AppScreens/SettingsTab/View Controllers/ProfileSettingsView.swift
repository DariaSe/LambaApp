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
            
            socialMediaTableView.setHeight(equalTo: CGFloat(userInfo.socialMedia.count * 80) + 40)
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
    
    private let buttonsStackView = UIStackView()
    
    private let changePasswordButton = AppButton()
    private let logoutButton = AppButton()
    
    private let refreshControl = UIRefreshControl()
    
    var delegate: SettingsDelegate? {
        didSet {
            socialMediaTableView.delegate = delegate
            hashtagsView.delegate = delegate
        }
    }
    
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
        stackView.addArrangedSubview(buttonsStackView)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 12
        buttonsStackView.alignment = .fill
        buttonsStackView.addArrangedSubview(changePasswordButton)
        buttonsStackView.addArrangedSubview(logoutButton)
        
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
        
        changePasswordButton.setWidth(equalTo: self, multiplier: 0.9)
        changePasswordButton.setTitle(Strings.changePassword, for: .normal)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        
        logoutButton.isSolid = false
        logoutButton.setWidth(equalTo: self, multiplier: 0.9)
        logoutButton.setTitle(Strings.logout, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        delegate?.refresh()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [unowned self] in
            self.refreshControl.endRefreshing()
        })
    }
    
    @objc func changePhotoButtonPressed() {
        changePhotoButton.animate(scale: 1.1)
        delegate?.changePhoto()
    }
    
    @objc func changePasswordButtonPressed() {
        changePasswordButton.animate(scale: 1.05)
        delegate?.changePassword()
    }
    
    @objc func logoutButtonPressed() {
        logoutButton.animate(scale: 1.05)
        delegate?.logout()
    }
}

