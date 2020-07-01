//
//  SortingCollectionViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 03.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SortingCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SocialCell"
    
    let containerView = UIView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        containerView.constrainToEdges(of: contentView, leading: 3, trailing: 3, top: 7, bottom: 8)
        label.constrainToEdges(of: containerView, leading: 16, trailing: 16, top: nil, bottom: nil)
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        containerView.layer.cornerRadius = 13
        containerView.setHeight(equalTo: 25)
        label.font = UIFont.systemFont(ofSize: 13)
    }
    
    func update(with option: SortingOption) {
        let arrow = option.sortingDirection == .descending ? Strings.arrowDown : Strings.arrowUp
        label.text = option.title + " " + arrow
        containerView.backgroundColor = option.isSelected ? UIColor.tintColor : UIColor.textControlsBackgroundColor
        label.textColor = option.isSelected ? UIColor.white : UIColor.tintColor
    }
}
