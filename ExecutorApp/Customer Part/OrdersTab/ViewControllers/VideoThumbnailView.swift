//
//  VideoThumbnailView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class VideoThumbnailView: UIView {
    
    let stackView = UIStackView()
    let imageContainerView = UIView()
    let thumbnailImageView = UIImageView()
    let playButton = UIButton()
    let downloadButton = UIButton(title: Strings.downloadVideo)
    
    let movieImage = UIImage(named: "Movie")?.withRenderingMode(.alwaysTemplate)
    
    var play: (() -> Void)?
    var download: (() -> Void)?
    
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
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.addArrangedSubview(imageContainerView)
        stackView.addArrangedSubview(downloadButton)
        
        thumbnailImageView.pinToEdges(to: imageContainerView)
        thumbnailImageView.setWidth(equalTo: stackView)
        thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 0.65).isActive = true
        thumbnailImageView.layer.cornerRadius = 15
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.5)
        thumbnailImageView.image = movieImage
        
        playButton.center(in: imageContainerView)
        playButton.setSize(width: 60, height: 60)
        playButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let playImage = UIImage(named: "Play")?.withRenderingMode(.alwaysTemplate)
        playButton.setImage(playImage, for: .normal)
        playButton.tintColor = UIColor.lightGray
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        
        downloadButton.setWidth(equalTo: self)
        downloadButton.setTitleColor(UIColor.tintColor, for: .normal)
        downloadButton.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
    }
    
    @objc func playButtonPressed() {
        playButton.animate(scale: 1.1)
        play?()
    }
    
    @objc func downloadButtonPressed() {
        downloadButton.animate(scale: 1.05)
        download?()
    }
    
    func setImage(imageURL: URL?) {
        if let imageURL = imageURL {
            thumbnailImageView.downloadImageFrom(url: imageURL)
        }
        else {
            thumbnailImageView.image = movieImage
        }
    }
}
