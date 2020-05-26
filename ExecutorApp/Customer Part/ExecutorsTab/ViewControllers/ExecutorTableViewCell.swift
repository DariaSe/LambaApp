//
//  ExecutorTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ExecutorCell"
    
    private let stackView = UIStackView()

    private let leftImageView = UIImageView()
    
    private let nameHashtagsStackView = UIStackView()
    private let nameLabel = UILabel()
    private let hashtagsLabel = UILabel()
    
    private let favoriteButton = UIButton()
    
    private let heart = UIImage(named: "Heart")?.withRenderingMode(.alwaysTemplate)
    
    var favoritePressed: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupLayout() {
        stackView.constrainToEdges(of: contentView, leading: 0, trailing: 0, top: 5, bottom: 5)
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.addArrangedSubview(leftImageView)
        stackView.addArrangedSubview(nameHashtagsStackView)
        stackView.addArrangedSubview(favoriteButton)
        leftImageView.setSize(width: 76, height: 76)
        
        nameHashtagsStackView.axis = .vertical
        nameHashtagsStackView.spacing = 10
        nameHashtagsStackView.alignment = .leading
        nameHashtagsStackView.addArrangedSubview(nameLabel)
        nameHashtagsStackView.addArrangedSubview(hashtagsLabel)
        
        favoriteButton.setSize(width: 38, height: 35)
    }
    
    private func initialSetup() {
        leftImageView.layer.masksToBounds = true
        leftImageView.image = InfoService.shared.placeholderImage
        leftImageView.contentMode = .scaleAspectFill
        leftImageView.layer.cornerRadius = 10
        
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        
        hashtagsLabel.textAlignment = .left
        hashtagsLabel.font = UIFont.systemFont(ofSize: 13)
        hashtagsLabel.textColor = UIColor.lightGray
        
        favoriteButton.setImage(heart, for: .normal)
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
    }
    
    @objc func favoriteButtonPressed() {
        favoriteButton.animate(scale: 1.1)
        favoritePressed?()
    }
    
    func update(with executor: Executor, imageURL: URL) {
        leftImageView.downloadImageFrom(url: imageURL)
//        leftImageView.image = executor.image ?? InfoService.shared.placeholderImage
        nameLabel.text = executor.name
        hashtagsLabel.text = executor.hashtags
        favoriteButton.tintColor = executor.isFavorite ? UIColor.destructiveColor : UIColor.lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
        selectedBackgroundView = view
    }
    
    override func prepareForReuse() {
        leftImageView.image = InfoService.shared.placeholderImage
    }
}
