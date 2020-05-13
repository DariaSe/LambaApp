//
//  OrderDetailsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import AVKit

class OrderDetailsViewController: UIViewController {
    
    weak var coordinator: OrdersCoordinator?
    
    var orderDetails: OrderDetails? {
        didSet {
            guard let orderDetails = orderDetails else { return }
            title = orderDetails.orderTypeTitle
            costView.cost = orderDetails.cost + " " + (InfoService.userInfo?.currencySign ?? "")
            orderInfoView.orderDetailUnits = orderDetails.units
            statusView.status = orderDetails.status
            statusView.delegate = self
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

extension OrderDetailsViewController: VideoActionsDelegate {
    func showUploadOptions() {
        guard let orderDetails = orderDetails else { return }
        coordinator?.showUploadOptions(orderID: orderDetails.id)
    }
    
    func reject() {
        guard let orderDetails = orderDetails else { return }
        coordinator?.rejectOrder(orderID: orderDetails.id)
    }
    
    func openVideo() {
        guard let orderDetails = orderDetails, let url = orderDetails.videoURL else { return }
        let player = AVPlayer(url: url)
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        self.present(vcPlayer, animated: true, completion: nil)
    }
}
