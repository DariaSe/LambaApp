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
    private let switchStackView = UIStackView()
    
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
        stackView.pinToLayoutMargins(to: contentView)
        stackView.axis = .horizontal
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(switchStackView)
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 12
        labelsStackView.alignment = .top
        labelsStackView.addArrangedSubview(optionTitleLabel)
        labelsStackView.addArrangedSubview(nameLabel)
        
        switchStackView.axis = .vertical
        switchStackView.spacing = 5
        switchStackView.alignment = .bottom
        switchStackView.addArrangedSubview(optionSwitch)
        switchStackView.addArrangedSubview(optionTitleLabel)
        
        optionTitleLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        costLabel.font = UIFont.systemFont(ofSize: 14)
        costLabel.textColor = UIColor.lightGray
        costLabel.textAlignment = .center
    }
    
    func update(with option: OrderSettings, name: String?) {
        optionTitleLabel.text = option.title
        costLabel.text = option.currencySign == "₽" ? option.price + option.currencySign : option.currencySign + option.price
        nameLabel.text = name
    }
}
