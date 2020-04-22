//
//  OrderDetailsInfoView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderDetailsInfoView: UIView {
    
    var units: [OrderDetailUnit] = [] {
        didSet {
            for unit in units {
                let unitView = OrderDetailsUnitView()
                unitView.titleText = unit.title
                unitView.dataText = unit.data
                stackView.addArrangedSubview(unitView)
            }
        }
    }
    
    private let stackView = UIStackView()

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
        stackView.spacing = 12
    }
}
