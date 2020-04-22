//
//  OrderDetailsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let costView = CostView()
    let orderInfoView = OrderDetailsInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        stackView.pinToLayoutMargins(to: view)
        stackView.axis = .vertical
        stackView.addArrangedSubview(costView)
        stackView.addArrangedSubview(orderInfoView)
    }
    
    func update(with orderDetails: OrderDetails) {
        costView.cost = orderDetails.cost
        orderInfoView.units = orderDetails.units
    }

}
