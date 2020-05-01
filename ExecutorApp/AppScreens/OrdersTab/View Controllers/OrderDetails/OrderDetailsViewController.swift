//
//  OrderDetailsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    weak var coordinator: OrdersCoordinator?
    
    var orderDetails: OrderDetails? {
        didSet {
            guard let orderDetails = orderDetails else { return }
            let id = orderDetails.id
            costView.cost = orderDetails.cost + " " + orderDetails.currency
            orderInfoView.orderDetailUnits = orderDetails.units
            statusView.status = orderDetails.status
            statusView.openCamera = { [weak self] in
                self?.coordinator?.openCamera(orderID: id)
            }
            statusView.reject = { [weak self] in
                self?.coordinator?.rejectOrder(orderID: id)
            }
        }
    }
    
    let scrollView = UIScrollView()
    
    let stackView = UIStackView()
    
    let costView = CostView()
    let orderInfoView = OrderDetailsTableView()
    let statusView = OrderStatusView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setupSubviews()
    }
    
    private func setupSubviews() {
        stackView.pinToLayoutMargins(to: view, constant: 10)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.addArrangedSubview(costView)
        stackView.addArrangedSubview(orderInfoView)
        stackView.addArrangedSubview(statusView)
        costView.setHeight(equalTo: SizeConstants.sumViewHeight)
        costView.setWidth(equalTo: 100)
        orderInfoView.setWidth(equalTo: stackView)
        statusView.setWidth(equalTo: stackView)
    }
}

