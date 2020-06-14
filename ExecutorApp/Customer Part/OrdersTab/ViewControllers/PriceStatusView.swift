//
//  PriceStatusView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class PriceStatusView: UIView {
    
    var status: OrderStatus? {
        didSet {
            guard let status = status else { return }
            switch status {
            case .moderation:
                statusLabel.text = Strings.statusModeration
                statusView.backgroundColor = UIColor.moderationIndicatorColor
            case .active:
                statusLabel.text = Strings.statusActive
                statusView.backgroundColor = UIColor.yellowIndicatorColor
            case .done:
                statusLabel.text = Strings.statusDone
                statusView.backgroundColor = UIColor.greenIndicatorColor
            case .rejectedExecutor:
                statusLabel.text = Strings.statusRejectedExecutor
                statusView.backgroundColor = UIColor.redIndicatorColor
            case .rejectedCustomer:
                statusLabel.text = Strings.statusYouCancelled
                statusView.backgroundColor = UIColor.redIndicatorColor
            case .rejectedModerator:
                statusLabel.text = Strings.statusRejectedModerator
                statusView.backgroundColor = UIColor.redIndicatorColor
            case .uploading:
                statusLabel.text = Strings.statusUploading
                statusView.backgroundColor = UIColor.uploadIndicatorColor
            case .disputeInProcess:
                statusLabel.text = Strings.statusDispute
                statusView.backgroundColor = UIColor.disputeIndicatorColor
            }
        }
    }
    
    let stackView = UIStackView()
    let priceLabel = UILabel()
    let statusStackView = UIStackView()
    let statusLabel = UILabel()
    let statusView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: self)
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(statusStackView)
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 3
        statusStackView.alignment = .center
        statusStackView.addArrangedSubview(statusLabel)
        statusStackView.addArrangedSubview(statusView)
        statusView.setSize(width: 10, height: 10)
        statusView.layer.cornerRadius = 5
        
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        statusLabel.font = UIFont.systemFont(ofSize: 20)
        statusLabel.adjustsFontSizeToFitWidth = true
    }
}
