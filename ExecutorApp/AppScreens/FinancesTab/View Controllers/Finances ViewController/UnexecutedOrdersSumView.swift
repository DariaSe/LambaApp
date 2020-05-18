//
//  UnexecutedOrdersSumView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class UnexecutedOrdersSumView: UIView {
    
    var sum: String = "" {
        didSet {
            sumView.text = sum
        }
    }
    
    private let stackView = UIStackView()
    
    private let label = UILabel()
    private let sumView = SumView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow(height: 2, shadowRadius: 3, opacity: 0.1, cornerRadius: 20)
    }
    
    private func initialSetup() {
        backgroundColor = UIColor.unexecutedBgColor
        layer.cornerRadius = 20
        stackView.pinToLayoutMargins(to: self)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(sumView)
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.text = Strings.unexecutedOrders
        
        sumView.setHeight(equalTo: SizeConstants.sumViewHeight)
        sumView.setWidth(equalTo: 120)
    }

}
