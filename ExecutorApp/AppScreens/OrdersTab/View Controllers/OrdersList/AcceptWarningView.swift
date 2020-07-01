//
//  AcceptWarningView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AcceptWarningView: UIView {
    
    let stackView = UIStackView()
    
    let label = UILabel()
    let button = UIButton(title: Strings.why)
    
    var whyPressed: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        backgroundColor = UIColor.destructiveColor
        label.text = Strings.notReceivingOrders
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        button.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        let why = Strings.why
        let whyWidth = why.width(withConstrainedHeight: 14, font: UIFont.systemFont(ofSize: 14))
        print(whyWidth)
        button.setWidth(equalTo: max(80, (whyWidth + 10)))
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        stackView.constrainToEdges(of: self, leading: 20, trailing: 20, top: nil, bottom: nil)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
    }
    
    @objc func buttonPressed() {
        button.animate(scale: 1.1)
        whyPressed?()
    }
}
