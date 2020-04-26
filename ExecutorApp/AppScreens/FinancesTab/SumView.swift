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
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 15).cgPath
        layer.shadowRadius = 6
    }
    
    private func initialSetup() {
        layer.cornerRadius = 15
        backgroundColor = UIColor.backgroundColor
        label.pinToLayoutMargins(to: self)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
