//
//  CustomerOrderDetailsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerOrderDetailsViewController: UIViewController {
    
    weak var coordinator: CustomerOrdersCoordinator?
    
    var orderDetails: OrderDetails? {
        didSet {
            guard let orderDetails = orderDetails else { return }
            title = orderDetails.orderTypeTitle
            priceStatusView.priceLabel.text = orderDetails.cost
            thumbnailView.setImage(imageURL: orderDetails.thumbnailURL)
            priceStatusView.status = orderDetails.status
            orderDetailsTableView.orderDetailUnits = orderDetails.units
            switch orderDetails.status {
            case .active, .moderation:
                thumbnailView.isHidden = true
                cancelOpenDisputeButton.isHidden = false
                cancelOpenDisputeButton.setTitle(Strings.cancelOrder, for: .normal)
            case .done:
                thumbnailView.isHidden = false
                cancelOpenDisputeButton.isHidden = false
                cancelOpenDisputeButton.setTitle(Strings.openDispute, for: .normal)
            case .rejectedModerator:
                thumbnailView.isHidden = true
                cancelOpenDisputeButton.isHidden = false
                cancelOpenDisputeButton.setTitle(Strings.openDispute, for: .normal)
            default:
                thumbnailView.isHidden = true
                cancelOpenDisputeButton.isHidden = true
            }
        }
    }
   
    let stackView = UIStackView()
    
    let priceStatusView = PriceStatusView()
    
    let thumbnailView = VideoThumbnailView()
    let orderDetailsTableView = OrderDetailsTableView()
    
    let cancelOpenDisputeButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        stackView.constrainToLayoutMargins(of: view, leading: 10, trailing: 10, top: 10, bottom: 30)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.addArrangedSubview(priceStatusView)
        stackView.addArrangedSubview(thumbnailView)
        stackView.addArrangedSubview(orderDetailsTableView)
        stackView.addArrangedSubview(cancelOpenDisputeButton)
        
        priceStatusView.setWidth(equalTo: stackView)
        thumbnailView.setWidth(equalTo: 245)
        orderDetailsTableView.setWidth(equalTo: stackView)
        cancelOpenDisputeButton.setWidth(equalTo: stackView)
        
        thumbnailView.play = { [unowned self] in
            self.coordinator?.playVideo(url: self.orderDetails?.videoURL)
        }
        thumbnailView.download = { [unowned self] in
            self.coordinator?.downloadVideo(url: self.orderDetails?.videoURL)
        }
        cancelOpenDisputeButton.isDestructive = true
        cancelOpenDisputeButton.addTarget(self, action: #selector(cancelOpenDisputeButtonPressed), for: .touchUpInside)
    }
    
    @objc func cancelOpenDisputeButtonPressed() {
        cancelOpenDisputeButton.animate(scale: 1.05)
        guard let orderDetails = orderDetails else { return }
        switch orderDetails.status {
        case .active, .moderation:
            coordinator?.cancelOrder(orderID: orderDetails.id)
        case .done, .rejectedModerator:
            coordinator?.openDispute(orderID: orderDetails.id)
        default:
            break
        }
    }
}
