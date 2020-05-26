//
//  CustomerOrdersCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerOrdersCoordinator: Coordinator {
    
    let ordersVC = CustomerOrdersViewController()
    let orderDetailsVC = CustomerOrderDetailsViewController()
    
    let ordersApiService = CustomerOrdersApiService()
    
    func start() {
        ordersVC.coordinator = self
        errorVC.reload = { [unowned self] in self.getOrders() }
        navigationController.viewControllers = [ordersVC]
        let envelopeImage = UIImage(named: "Envelope")
        ordersVC.tabBarItem = UITabBarItem(title: Strings.orders, image: envelopeImage, tag: 0)
        ordersVC.title = Strings.orders
    }
  
    func getOrders() {
        errorVC.reload = { [unowned self] in self.getOrders() }
        showLoadingIndicator()
        ordersApiService.getOrders { [unowned self] orders, imageURLs, errorMessage in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
            }
            else if let orders = orders {
                self.removeFullScreenError()
                if !orders.isEmpty {
                    self.ordersVC.orders = orders
                }
                else {
                    self.showFullScreenError(message: Strings.noOrdersYet)
                }
                if let imageURLs = imageURLs {
                    self.ordersVC.imageURLs = imageURLs
                }
            }
        }
    }
    
    func loadMore() {
        if ordersApiService.isMore {
            showLoadingIndicator()
            ordersApiService.page += 1
            ordersApiService.getOrders { [unowned self] orders, imageURLs, errorMessage in
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showPopUpError(message: errorMessage)
                }
                if let orders = orders {
                    self.ordersVC.orders.append(contentsOf: orders)
                }
                if let imageURLs = imageURLs {
                    self.ordersVC.imageURLs = imageURLs
                }
            }
        }
    }
    
    func refresh() {
        ordersApiService.page = 1
        getOrders()
    }
    
    func showOrderDetails(orderID: Int) {
        orderDetailsVC.coordinator = self
        navigationController.pushViewController(orderDetailsVC, animated: true)
        getOrderDetails(orderID: orderID)
    }
    
    func getOrderDetails(orderID: Int) {
        errorVC.reload = { [unowned self] in self.getOrderDetails(orderID: orderID) }
        showFullScreenLoading()
        ordersApiService.showOrderDetails(orderID: orderID) { [unowned self] orderDetails, errorMessage in
            self.removeFullScreenLoading()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
                
            }
            else {
                self.removeFullScreenError()
//                self.orderDetailsVC.orderDetails = orderDetails
            }
        }
    }
    
}
