//
//  OrderTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderCell"
    
    private let stackView = UIStackView()
    
    private let containerView = UIView()
    private let shadowView = UIView()
    
    private let leftImageView = UIImageView()
    
    private let sumDescrStackView = UIStackView()
    private let costLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let statusDateStackView = UIStackView()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let statusIndicatorView = UIView()
    
    private var imageViewHeightConstraint = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.dropShadow(height: 0, shadowRadius: 3, opacity: 0.1, cornerRadius: 15)
    }
    
    private func setupLayout() {
        shadowView.pinToEdges(to: contentView, constant: 4)
        containerView.pinToEdges(to: contentView, constant: 4)
        containerView.clipsToBounds = true
        
        statusIndicatorView.constrainToEdges(of: containerView, leading: nil, trailing: 0, top: 0, bottom: 0)
        statusIndicatorView.setWidth(equalTo: 15)
        
        stackView.constrainToEdges(of: containerView, leading: 18, trailing: 22, top: 0, bottom: 0)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 14
        stackView.addArrangedSubview(leftImageView)
        stackView.addArrangedSubview(sumDescrStackView)
        stackView.addArrangedSubview(statusDateStackView)
        imageViewHeightConstraint = leftImageView.heightAnchor.constraint(equalToConstant: 48)
        imageViewHeightConstraint.isActive = true
        leftImageView.widthAnchor.constraint(equalTo: leftImageView.heightAnchor).isActive = true
        
        sumDescrStackView.axis = .vertical
        sumDescrStackView.spacing = 4
        sumDescrStackView.alignment = .leading
        sumDescrStackView.addArrangedSubview(costLabel)
        sumDescrStackView.addArrangedSubview(descriptionLabel)
        
        statusDateStackView.axis = .vertical
        statusDateStackView.spacing = 13
        statusDateStackView.alignment = .trailing
        statusDateStackView.addArrangedSubview(statusLabel)
        statusDateStackView.addArrangedSubview(dateLabel)
    }
    
    private func initialSetup() {
        containerView.backgroundColor = UIColor.backgroundColor
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        leftImageView.image = UIImage(named: "DollarSign")
        leftImageView.layer.cornerRadius = 10
        leftImageView.clipsToBounds = true
        leftImageView.contentMode = .scaleAspectFill
        
        costLabel.textAlignment = .left
        costLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = UIColor.gray
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.gray
    }
    
    func update(with order: Order, userRole: UserRole) {
        imageViewHeightConstraint.constant = userRole == .executor ? 25 : 48
        if let url = URL(string: order.imageURLString ?? "") {
            leftImageView.downloadImageFrom(url: url)
        }
        else {
            leftImageView.image = userRole == .executor ? UIImage(named: "DollarSign") : InfoService.shared.placeholderImage
        }
        costLabel.text = order.cost
        descriptionLabel.text = order.orderTypeTitle
        statusLabel.text = Order.statusString(status: order.status)
        dateLabel.text = order.date
        switch order.status {
        case .moderation:
            statusLabel.text = Strings.statusModeration
            statusIndicatorView.backgroundColor =  UIColor.lightGray
        case .done:
            statusLabel.text = Strings.statusDone
            statusIndicatorView.backgroundColor =  UIColor.greenIndicatorColor
        case .active:
            statusLabel.text = Strings.statusActive
            statusIndicatorView.backgroundColor = UIColor.yellowIndicatorColor
        case .rejectedExecutor:
            statusLabel.text = userRole == .executor ? Strings.statusYouRejected : Strings.statusRejectedExecutor
            statusIndicatorView.backgroundColor = UIColor.redIndicatorColor
        case .rejectedCustomer:
            statusLabel.text = userRole == .executor ? "" : Strings.statusYouCancelled
            statusIndicatorView.backgroundColor = UIColor.redIndicatorColor
        case .rejectedModerator:
            statusLabel.text = Strings.statusRejectedModerator
            statusIndicatorView.backgroundColor =  UIColor.redIndicatorColor
        case .uploading:
            statusLabel.text = Strings.statusUploading
            statusIndicatorView.backgroundColor = UIColor.gray
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
        selectedBackgroundView = view
        
        // Configure the view for the selected state
    }
    
}
