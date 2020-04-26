//
//  OrderDetailTableViewCell.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderDetailCell"
    
    let view = OrderDetailsUnitView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        view.constrainToEdges(of: contentView, leading: 0, trailing: 0, top: 10, bottom: 10)
    }
    
    func update(with unit: OrderDetailUnit) {
        view.titleText = unit.title
        view.dataText = unit.data
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
