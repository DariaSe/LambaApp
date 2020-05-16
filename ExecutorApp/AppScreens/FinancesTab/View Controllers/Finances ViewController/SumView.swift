//
//  SumView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SumView: UIView {
    
    var text: String = "" {
        didSet {
            label.text = text
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
        dropShadow(height: 2, shadowRadius: 1, opacity: 0.1, cornerRadius: 15)
    }
    
    private func initialSetup() {
        layer.cornerRadius = 15
        backgroundColor = UIColor.backgroundColor
        label.pinToLayoutMargins(to: self)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
    }
}
