//
//  ReadyToTransferTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ReadyToTransferTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ReadyToTransferCell"
    
    private let stackView = UIStackView()
    
    private let titleLabel = UILabel()
    private let sumLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.backgroundColor = UIColor.readyToTransferBgColor
        stackView.constrainToEdges(of: contentView, leading: 0, trailing: 0, top: 10, bottom: 10)
        stackView.axis = .horizontal
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(sumLabel)
        
        titleLabel.textAlignment = .left
        sumLabel.textAlignment = .right
        sumLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func update(title: String, sum: String) {
        titleLabel.text = title
        sumLabel.text = sum
    }
    
}
