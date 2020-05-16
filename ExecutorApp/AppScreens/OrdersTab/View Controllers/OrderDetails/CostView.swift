//
//  CostView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CostView: UIView {
    
    var cost: String = "" {
        didSet {
            label.text = cost
        }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow(height: 2, shadowRadius: 3, opacity: 0.1, cornerRadius: 15)
    }
    
    
    private func initialSetup() {
        label.center(in: self)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = UIColor.white
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.tintColor
    }
}
