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
    
    private let moneySignImageView = UIImageView()
    
    private let sumDescrStackView = UIStackView()
    private let costLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let statusDateStackView = UIStackView()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()

    private let statusIndicatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        containerView.pinToEdges(to: contentView, constant: 3)
        containerView.clipsToBounds = true
        
        statusIndicatorView.constrainToEdges(of: containerView, leading: nil, trailing: 0, top: 0, bottom: 0)
        statusIndicatorView.setWidth(equalTo: 15)
        
        stackView.constrainToEdges(of: containerView, leading: 10, trailing: 22, top: 0, bottom: 0)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 14
        stackView.addArrangedSubview(moneySignImageView)
        stackView.addArrangedSubview(sumDescrStackView)
        stackView.addArrangedSubview(statusDateStackView)
        moneySignImageView.setSize(width: 36, height: 36)
        
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
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        moneySignImageView.image = UIImage(named: "DollarSign")
        
        costLabel.textAlignment = .left
        costLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = UIColor.gray
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.gray
    }
    
    func update(with order: Order) {
        costLabel.text = order.cost
        descriptionLabel.text = order.description
        statusLabel.text = order.status.rawValue
        dateLabel.text = order.date
        var color: UIColor {
            switch order.status {
            case .done:
                return UIColor.greenIndicatorColor
            case .todo:
                return UIColor.yellowIndicatorColor
            case .rejected:
                return UIColor.redIndicatorColor
            case .uploading:
                return UIColor.gray
            }
        }
        statusIndicatorView.backgroundColor = color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
