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
    
    var switchValueChanged: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
    }
    
    func update(with option: OrderSettings) {
        
    }
}
