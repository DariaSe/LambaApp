//
//  OrderOptionTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderOptionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderOptionCell"
    
    private let stackView = UIStackView()
    private let labelsStackView = UIStackView()
    
    private let optionTitleLabel = UILabel()
    private let nameLabel = UILabel()
    
    private let optionSwitch = AppSwitch()
    private let costLabel = UILabel()
    
    var switchValueChanged: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.addSubview(labelsStackView)
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        labelsStackView.axis = .vertical
//        labelsStackView.spacing = 12
        labelsStackView.alignment = .leading
        labelsStackView.addArrangedSubview(optionTitleLabel)
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.setHeight(equalTo: 44)
        
        contentView.addSubview(optionSwitch)
        optionSwitch.translatesAutoresizingMaskIntoConstraints = false
        optionSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        optionSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        
        contentView.addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.centerXAnchor.constraint(equalTo: optionSwitch.centerXAnchor).isActive = true
        costLabel.topAnchor.constraint(equalTo: optionSwitch.bottomAnchor, constant: 5).isActive = true
        
        optionTitleLabel.font = UIFont.systemFont(ofSize: 16)
        optionTitleLabel.textAlignment = .left
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        costLabel.font = UIFont.systemFont(ofSize: 14)
        costLabel.textColor = UIColor.lightGray
        costLabel.textAlignment = .center
    }
    
    func update(with option: OrderSettings, name: String?) {
        optionTitleLabel.text = option.title
        print(option.currencySign)
        costLabel.text = option.currencySign == "₽" ? "+" + option.price + option.currencySign : "+" + option.currencySign + option.price
        nameLabel.text = name
    }
}
