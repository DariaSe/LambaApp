//
//  OrdersCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorOrdersCoordinator: Coordinator {
    
    var ordersApiService = ExecutorOrdersApiService()
    let orderDetailsApiService = ExecutorOrderDetailsApiService()
    
    let ordersVC = OrdersViewController()
    let orderDetailsVC = OrderDetailsViewController()
    
    func start() {
        orderDetailsApiService.delegate = self
        navigationController.delegate = self
        ordersVC.coordinator = self
        errorVC.reload = { [weak self] in self?.getOrders() }
        navigationController.viewControllers = [ordersVC]
        let starImage = UIImage(named: "Star")
        ordersVC.tabBarItem = UITabBarItem(title: Strings.orders, image: starImage, tag: 0)
        ordersVC.title = Strings.orders
    }
    
    
    func getOrders() {
        ordersApiService.page = 1
        errorVC.reload = { [weak self] in self?.getOrders() }
        showLoadingIndicator()
        ordersApiService.getOrders { [weak self] orders, errorMessage in
            self?.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self?.showFullScreenError(message: errorMessage)
            }
            guard let orders = orders else { return }
            self?.removeFullScreenError()
            if !orders.isEmpty {
                self?.ordersVC.orders = orders
            }
            else {
                self?.showFullScreenError(message: Strings.noOrdersYet)
            }
        }
    }
    
    func loadMore() {
        if ordersApiService.isMore {
            showLoadingIndicator()
            ordersApiService.page += 1
            ordersApiService.getOrders { [weak self] orders, errorMessage in
                self?.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self?.showPopUpError(message: errorMessage)
                }
                if let orders = orders {
                    self?.ordersVC.orders.append(contentsOf: orders)
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
        errorVC.reload = { [weak self] in self?.getOrderDetails(orderID: orderID) }
        showFullScreenLoading()
        ordersApiService.showOrderDetails(orderID: orderID) { [weak self] orderDetails, errorMessage in
            self?.removeFullScreenLoading()
            if let errorMessage = errorMessage {
                self?.showFullScreenError(message: errorMessage)
                
            }
            else {
                self?.removeFullScreenError()
                self?.orderDetailsVC.orderDetails = orderDetails
            }
        }
    }
    
    func showUploadOptions(orderID: Int) {
        showLoadingIndicator()
        let alert = UIAlertController(title: Strings.chooseVideoSource, message: Strings.durationWarning, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: Strings.camera, style: .default) { [weak self] (_) in
            self?.openCamera(orderID: orderID)
        }
        let libraryAction = UIAlertAction(title: Strings.mediaLibrary, style: .default) { [weak self] (_) in
            self?.openLibrary(orderID: orderID)
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel) { [weak self] (_) in
            self?.removeLoadingIndicator()
        }
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        orderDetailsVC.present(alert, animated: true)
    }
    
    func openCamera(orderID: Int) {
        let cameraVC = CameraViewController()
        orderDetailsVC.add(cameraVC)
        cameraVC.showImagePicker()
        cameraVC.urlReceived = { [weak self] url, errorMessage in
            DispatchQueue.main.async {
                if let url = url {
                self?.uploadVideo(orderID: orderID, url: url)
                }
                else {
                    self?.removeLoadingIndicator()
                    if let errorMessage = errorMessage {
                        self?.showSimpleAlert(title: errorMessage, handler: nil)
                    }
                }
            }
        }
    }
    
    func openLibrary(orderID: Int) {
        let videoPicker = VideoPickerViewController()
        orderDetailsVC.add(videoPicker)
        videoPicker.showVideoPicker()
        videoPicker.urlReceived = { [weak self] url, errorMessage in
            DispatchQueue.main.async {
                if let url = url {
                    self?.uploadVideo(orderID: orderID, url: url)
                }
                else {
                    self?.removeLoadingIndicator()
                    if let errorMessage = errorMessage {
                        self?.showSimpleAlert(title: errorMessage, handler: nil)
                    }
                }
            }
        }
    }
    
    func uploadVideo(orderID: Int, url: URL) {
        showLoadingIndicator()
        orderDetailsApiService.setOrderStatus(status: .uploading, orderID: orderID) { [weak self] (success, errorMessage) in
            DispatchQueue.main.async {
                if success {
                    self?.orderDetailsVC.statusView.status = .uploading
                    self?.orderDetailsApiService.uploadVideo(orderID: orderID, url: url)
                }
                else {
                    self?.removeLoadingIndicator()
                    self?.showSimpleAlert(title: errorMessage ?? Strings.uploadError, handler: nil)
                }
            }
        }
    }
    
    
    func rejectOrder(orderID: Int) {
        let alert = UIAlertController(title: Strings.doYouWantToReject, message: Strings.actionCanNotBeUndone, preferredStyle: .alert)
        let rejectAction = UIAlertAction(title: Strings.reject, style: .destructive) { [weak self] (_) in
            self?.showLoadingIndicator()
            self?.orderDetailsApiService.rejectOrder(orderID: orderID) { [weak self] success, errorMessage  in
                DispatchQueue.main.async {
                    self?.removeLoadingIndicator()
                    if let errorMessage = errorMessage {
                        self?.showSimpleAlert(title: errorMessage, handler: nil)
                    }
                    if success {
                        self?.orderDetailsVC.statusView.status = .rejected
                    }
                    else {
                        self?.showSimpleAlert(title: Strings.error, handler: nil)
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(rejectAction)
        alert.addAction(cancelAction)
        orderDetailsVC.present(alert, animated: true)
    }
}

extension ExecutorOrdersCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == ordersVC {
            ordersApiService.page = 1
            getOrders()
        }
    }
}

extension ExecutorOrdersCoordinator: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async { [weak self] in
            self?.removeLoadingIndicator()
            if let error = error {
                self?.showSimpleAlert(title: error.localizedDescription, handler: nil)
            }
            else {
                if self?.navigationController.topViewController == self?.orderDetailsVC, let orderDetails = self?.orderDetailsVC.orderDetails {
                    self?.getOrderDetails(orderID: orderDetails.id)
                }
                else {
                    self?.getOrders()
                }
            }
        }
    }
}
