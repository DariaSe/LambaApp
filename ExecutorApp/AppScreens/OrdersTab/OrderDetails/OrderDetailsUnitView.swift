//
//  OrderDetailsUnitView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderDetailsUnitView: UIView {
    
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    var dataText: String = "" {
        didSet {
            dataLabel.text = dataText
        }
    }
    
    private let stackView = UIStackView()
    
    private let titleLabel = UILabel()
    private let dataLabel = UILabel()
    
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
        stackView.spacing = 10
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dataLabel)
       
        titleLabel.textAlignment = .natural
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.gray
        titleLabel.text = "Title"
        
        dataLabel.textAlignment = .center
        dataLabel.font = UIFont.systemFont(ofSize: 24)
        dataLabel.textColor = UIColor.gray
        dataLabel.text = "Some text"
    }
    
}
