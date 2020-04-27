//
//  OrdersCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrdersCoordinator: Coordinator {
    
    var navigationController = UINavigationController()
    
    let apiService: OrdersApiService = OrdersApiServiceMock()
    
    lazy var loadingVC = LoadingViewController(backgroundColor: UIColor.backgroundColor)
    lazy var clearLoadingVC = LoadingViewController(backgroundColor: UIColor.clear)
    
    let ordersVC = OrdersViewController()
    let orderDetailsVC = OrderDetailsViewController()
    
    func start() {
        ordersVC.coordinator = self
        navigationController.viewControllers = [ordersVC]
        ordersVC.tabBarItem = UITabBarItem(title: Strings.orders, image: nil, tag: 0)
        ordersVC.title = Strings.orders
        ordersVC.add(loadingVC)
        apiService.getOrders { [weak self] (orders) in
            self?.loadingVC.remove()
            guard let orders = orders else {
                let errorVC = ErrorViewController()
                errorVC.reload = { [weak self] in
                    self?.start()
                }
                self?.ordersVC.add(errorVC)
                return
            }
            if !orders.isEmpty {
                self?.ordersVC.orders = orders
            }
            else {
                let emptyVC = EmptyViewController(message: Strings.noOrdersYet)
                emptyVC.reload = { [weak self] in
                    self?.start()
                }
                self?.ordersVC.add(emptyVC)
            }
        }
    }
    
    func loadMore() {
        if apiService.isMore {
            ordersVC.add(clearLoadingVC)
            apiService.loadMore { [weak self] (orders) in
                self?.clearLoadingVC.remove()
                guard let orders = orders else {
                    let popUpErrorVC = PopupErrorViewController(message: Strings.error)
                    self?.ordersVC.add(popUpErrorVC)
                    return }
                self?.ordersVC.orders.append(contentsOf: orders)
            }
        }
    }
    
    func showOrderDetails(orderID: Int) {
        orderDetailsVC.coordinator = self
        navigationController.pushViewController(orderDetailsVC, animated: true)
        orderDetailsVC.add(loadingVC)
        apiService.showOrderDetails(orderID: orderID) { [weak self] (orderDetails) in
            self?.loadingVC.remove()
            guard let orderDetails = orderDetails else {
                let errorVC = ErrorViewController()
                errorVC.reloadButton.isHidden = true
                self?.orderDetailsVC.add(errorVC)
                return
            }
            
            self?.orderDetailsVC.orderDetails = orderDetails
        }
    }
    
    func openCamera(orderID: Int) {
        let cameraVC = CameraViewController()
        orderDetailsVC.add(cameraVC)
        cameraVC.showImagePicker()
        cameraVC.urlReceived = { [weak self] url in
            self?.ordersVC.orders = self!.ordersVC.orders.map { $0.id == orderID ? $0.withStatus(.uploading) : $0 }
            self?.navigationController.popViewController(animated: true)
            self?.apiService.uploadVideo(orderID: orderID, url: url) { (id, success) in
                self?.clearLoadingVC.remove()
                if success {
                    
                }
            }
        }
    }
    
    func rejectOrder(orderID: Int) {
        let alert = UIAlertController(title: Strings.doYouWantToReject, message: Strings.actionCanNotBeUndone, preferredStyle: .alert)
        let rejectAction = UIAlertAction(title: Strings.reject, style: .destructive) { [weak self] (_) in
            self?.orderDetailsVC.add(self?.clearLoadingVC ?? LoadingViewController())
            self?.apiService.rejectOrder(orderID: orderID) { [weak self] (success) in
                self?.clearLoadingVC.remove()
                if success {
                    self?.orderDetailsVC.statusView.status = .rejected
                }
                else {
                    let popUpErrorVC = PopupErrorViewController(message: Strings.error)
                    self?.orderDetailsVC.add(popUpErrorVC)
                }
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(rejectAction)
        alert.addAction(cancelAction)
        orderDetailsVC.present(alert, animated: true)
    }
}
