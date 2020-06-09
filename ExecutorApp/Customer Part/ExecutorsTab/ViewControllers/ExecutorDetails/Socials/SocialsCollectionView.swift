//
//  SocialsCollectionView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SocialsCollectionView: UIView {
    
    var socials: [SocialMedia] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var openURL: ((URL) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }()
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        collectionView.pinToEdges(to: self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SocialMediaCollectionViewCell.self, forCellWithReuseIdentifier: SocialMediaCollectionViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
    }
    
}

extension SocialsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SocialMediaCollectionViewCell.reuseIdentifier, for: indexPath) as! SocialMediaCollectionViewCell
        let imageURLString = socials[indexPath.row].imageURLString
        cell.setImage(urlString: imageURLString)
        return cell
    }
    
    
}

extension SocialsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension SocialsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let socialMedia = socials[indexPath.row]
        var urlString = socialMedia.url
        if !urlString.hasPrefix("http") {
            urlString = "https://" + urlString
        }
        if let url = URL(string: urlString) {
            openURL?(url)
        }
    }
}
