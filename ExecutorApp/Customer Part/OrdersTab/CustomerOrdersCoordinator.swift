//
//  CustomerOrdersCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import AVKit
import Photos
import MessageUI

class CustomerOrdersCoordinator: Coordinator {
    
    let ordersVC = CustomerOrdersViewController()
    let orderDetailsVC = CustomerOrderDetailsViewController()
    
    let ordersApiService = CustomerOrdersApiService()
    
    var isMore: Bool = false
    
    var page: Int = 1
    var limit: Int = 10
    
    var currentOrderID: Int?
    
    func start() {
        ordersApiService.coordinator = self
        navigationController.delegate = self
        ordersApiService.delegate = self
        ordersVC.coordinator = self
        ordersVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        orderDetailsVC.coordinator = self
        orderDetailsVC.hidesBottomBarWhenPushed = true
        errorVC.reload = { [unowned self] in self.getOrders() }
        navigationController.viewControllers = [ordersVC]
        let envelopeImage = UIImage(named: "Envelope")
        ordersVC.tabBarItem = UITabBarItem(title: Strings.orders, image: envelopeImage, tag: 0)
        ordersVC.title = Strings.orders
    }
    
    func getOrders() {
        errorVC.reload = { [unowned self] in self.getOrders() }
        showLoadingIndicator()
        ordersApiService.getOrders(page: page, limit: limit) { [unowned self] orders, errorMessage in
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
            }
        }
    }
    
    func loadMore() {
        if isMore {
            showLoadingIndicator()
            page += 1
            ordersApiService.getOrders(page: page, limit: limit) { [unowned self] orders, errorMessage in
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showPopUpError(message: errorMessage)
                }
                if let orders = orders {
                    self.ordersVC.orders.append(contentsOf: orders)
                }
            }
        }
    }
    
    func getPreviousOrders() {
        if page > 1 {
            showLoadingIndicator()
            page += 1
            ordersApiService.getOrders(page: page, limit: limit) { [unowned self] orders, errorMessage in
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showPopUpError(message: errorMessage)
                }
                if let orders = orders {
                    self.ordersVC.orders.insert(contentsOf: orders, at: 0)
                }
            }
        }
    }
    
    func refresh() {
        page = 1
        getOrders()
    }
    
    func showOrderDetails(orderID: Int) {
        navigationController.pushViewController(orderDetailsVC, animated: true)
        getOrderDetails(orderID: orderID)
    }
    
    func getOrderDetails(orderID: Int) {
        errorVC.reload = { [unowned self] in self.getOrderDetails(orderID: orderID) }
        showFullScreenLoading()
        ordersApiService.getOrderDetails(orderID: orderID) { [unowned self] orderDetails, errorMessage in
            self.removeFullScreenLoading()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
            }
            else {
                self.removeFullScreenError()
                self.orderDetailsVC.orderDetails = orderDetails
            }
        }
    }
    
    func playVideo(url: URL?) {
        guard let url = url else { return }
        let player = AVPlayer(url: url)
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        orderDetailsVC.present(vcPlayer, animated: true, completion: nil)
    }
    
    func downloadVideo(url: URL?) {
        guard let url = url else { return }
        let alert = UIAlertController(title: Strings.saveVideoToLibrary, message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: Strings.save, style: .default) { [unowned self] (_) in
            PHPhotoLibrary.requestAuthorization { (authStatus) in
                DispatchQueue.main.async {
                    guard authStatus == .authorized else {
                        let settingsAlert = PermissionsService.alertToSettings(title: Strings.accessError, message: Strings.allowMediaAccess)
                        self.orderDetailsVC.present(settingsAlert, animated: true)
                        return
                    }
                    self.showLoadingIndicator()
                    self.ordersApiService.downloadVideo(url: url)
                }
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        orderDetailsVC.present(alert, animated: true, completion: nil)
        
    }
    
    func showCancelOrderAlert(orderID: Int) {
        let alert = UIAlertController(title: Strings.cancelOrder + "?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
            self.cancelOrder(orderID: orderID)
        }
        let cancelAction = UIAlertAction(title: Strings.no, style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        orderDetailsVC.present(alert, animated: true)
    }
    
    func cancelOrder(orderID: Int) {
        showLoadingIndicator()
        ordersApiService.cancelOrder(orderID: orderID) { [unowned self] success, errorMessage in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
                else if success {
                    self.getOrderDetails(orderID: orderID)
                    if var changedOrder = self.ordersVC.orders.filter({ $0.id == orderID}).first,
                        let index = self.ordersVC.orders.firstIndex(of: changedOrder) {
                        changedOrder.status = .rejectedCustomer
                        self.ordersVC.orders[index] = changedOrder
                    }
                }
            }
        }
    }
    
    func openDispute(orderID: Int) {
        currentOrderID = orderID
        let firstName = InfoService.shared.userInfo?.firstName ?? ""
        let lastName = InfoService.shared.userInfo?.lastName ?? ""
        let userEmail = InfoService.shared.userInfo?.email ?? ""
        let emailTitle = [firstName, lastName, "-", Strings.disputeOnOrder, orderID.string].joined(separator: " ")
        let messageBody = ["\n\n", (firstName + " " + lastName), userEmail].joined(separator: "\n")
        let toRecipents = ["daria.samosledova@gmail.com"]
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setSubject(emailTitle)
        mailVC.setMessageBody(messageBody, isHTML: false)
        mailVC.setToRecipients(toRecipents)
        
        orderDetailsVC.present(mailVC, animated: true, completion: nil)
    }
}


extension CustomerOrdersCoordinator: URLSessionDataDelegate, URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let localFileName = downloadTask.response?.url?.lastPathComponent else { return }
        let suggestedFileName = downloadTask.response?.suggestedFilename
        VideoService.saveDownloadedVideo(suggestedFileName: suggestedFileName, localFileName: localFileName, location: location) { [unowned self] (success, errorMessage) in
            DispatchQueue.main.async {
                if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
                else if success {
                    let alert = UIAlertController(title: Strings.videoDownloaded, message: nil, preferredStyle: .alert)
                    let photosAction = UIAlertAction(title: Strings.goToPhotos, style: .default) { (_) in
                        UIApplication.shared.open(URL(string:"photos-redirect://")!)
                    }
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(photosAction)
                    alert.addAction(okAction)
                    self.navigationController.topViewController?.present(alert, animated: true)
                }
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async { [unowned self] in
            self.removeLoadingIndicator()
            if let error = error {
                self.showSimpleAlert(title: error.localizedDescription, handler: nil)
            }
        }
    }
}

extension CustomerOrdersCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == ordersVC {
            orderDetailsVC.thumbnailView.setImage(imageURL: nil)
        }
    }
}

extension CustomerOrdersCoordinator: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        guard let currentOrderID = currentOrderID else {
            return
        }
        switch result {
        case .sent:
            showLoadingIndicator()
            ordersApiService.openDispute(orderID: currentOrderID) { [unowned self] (success, errorMessage) in
                DispatchQueue.main.async {
                    self.removeLoadingIndicator()
                    if let errorMessage = errorMessage {
                        self.showSimpleAlert(title: errorMessage, handler: nil)
                    }
                    else if success {
                        self.getOrderDetails(orderID: currentOrderID)
                        if var changedOrder = self.ordersVC.orders.filter({ $0.id == currentOrderID}).first,
                            let index = self.ordersVC.orders.firstIndex(of: changedOrder) {
                            changedOrder.status = .disputeInProcess
                            self.ordersVC.orders[index] = changedOrder
                        }
                    }
                }
            }
        case .failed:
            if let error = error {
                self.showSimpleAlert(title: error.localizedDescription, handler: nil)
            }
        default:
            break
        }
    }
}

