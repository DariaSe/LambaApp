//
//  SocialMediaCollectionViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SocialMediaCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SocialCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        imageView.pinToEdges(to: contentView)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
    }
    
    func setImage(urlString: String) {
        if let url = URL(string: urlString) {
            imageView.downloadImageFrom(url: url)
        }
    }
}
