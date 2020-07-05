//
//  ExecutorsTabCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import SafariServices

class ExecutorsTabCoordinator: Coordinator {
    
    let executorsListVC = ExecutorsListViewController()
    
    lazy var executorDetailsVC: ExecutorDetailsViewController = {
        let detailsVC = ExecutorDetailsViewController()
        detailsVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        detailsVC.coordinator = self
        detailsVC.hidesBottomBarWhenPushed = true
        return detailsVC
    }()
    
    lazy var orderOptionsVC: OrderOptionsViewController = {
        let optionsVC = OrderOptionsViewController()
        optionsVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        optionsVC.coordinator = self
        return optionsVC
    }()
    
    lazy var payVC: PayViewController = {
        let payViewController = PayViewController()
        payViewController.coordinator = self
        return payViewController
    }()
    
    lazy var infoVC = SimpleInfoViewController()
    
    let apiService = ExecutorsApiService()
    
    var searchString: String = "" {
        didSet {
            getExecutors()
        }
    }
    
    var sortingOption: SortingOption = SortingOption(title: Strings.popularityOption, sortingOrder: .popularity, sortingDirection: .descending, isSelected: true) {
        didSet {
            getExecutors()
        }
    }
    
    var currentExecutor: ExecutorDetails?
    
    var orderPreform: OrderPreform?
    
    func start() {
        navigationController.delegate = self
        executorsListVC.coordinator = self
        executorsListVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController.viewControllers = [executorsListVC]
        errorVC.reload = { [unowned self] in self.getExecutors() }
        let starImage = UIImage(named: "Star")
        executorsListVC.tabBarItem = UITabBarItem(title: Strings.executors, image: starImage, tag: 0)
        executorsListVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func setImage(_ image: UIImage?) {
        executorsListVC.userImage = image
    }
    
    
    func getExecutors(order: String = "") {
        removeEmptyScreen()
        showLoadingIndicator()
        let sortingOrder = sortingOption.sortingOrder.rawValue
        let sortingDirection = sortingOption.sortingDirection.rawValue
        apiService.getExecutors(search: searchString, order: sortingOrder, direction: sortingDirection) { [unowned self] (executors, errorMessage) in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
            }
            if let executors = executors {
                if !executors.isEmpty {
                    self.executorsListVC.executors = executors
                }
                else {
                    self.showEmptyScreen(message: Strings.noSearchResults)
                }
            }
        }
    }
    
    func loadMore(order: String = "") {
        if apiService.isMore {
            showLoadingIndicator()
            apiService.page += 1
            let sortingOrder = sortingOption.sortingOrder.rawValue
            let sortingDirection = sortingOption.sortingDirection.rawValue
            apiService.getExecutors(search: searchString, order: sortingOrder, direction: sortingDirection) { [unowned self] (executors, errorMessage) in
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showPopUpError(message: errorMessage)
                }
                if let executors = executors {
                    self.executorsListVC.executors.append(contentsOf: executors)
                }
            }
        }
    }
    
    func refresh() {
        apiService.page = 1
        searchString = ""
        getExecutors()
    }
    
    func setFavorite(executorID: Int) {
        apiService.setFavorite(executorID: executorID) { [unowned self] (success, errorMessage) in
            DispatchQueue.main.async {
                if success {
                    self.executorsListVC.executors = self.executorsListVC.executors.map{$0.id == executorID ? $0.favoriteChanged() : $0}
                    if self.navigationController.topViewController == self.executorDetailsVC {
                        guard let executorDetails = self.executorDetailsVC.executorDetails else { return }
                        self.getExecutorDetails(executorID: executorDetails.id)
                    }
                }
                if let errorMessage = errorMessage {
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
            }
        }
    }
    
    func getExecutorDetails(executorID: Int) {
        removeEmptyScreen()
        errorVC.reload = { [unowned self] in self.getExecutorDetails(executorID: executorID) }
        orderPreform = OrderPreform(executorID: executorID)
        if navigationController.topViewController == executorsListVC {
            navigationController.pushViewController(executorDetailsVC, animated: true)
            showFullScreenLoading()
        }
        apiService.getExecutorDetails(executorID: executorID) { [unowned self] (executorDetails, errorMessage) in
            self.removeFullScreenLoading()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
            }
            if let executorDetails = executorDetails {
                self.currentExecutor = executorDetails
                self.executorDetailsVC.executorDetails = executorDetails
                self.executorDetailsVC.orderScheme = InfoService.shared.orderScheme
            }
        }
    }
    
    func openURL(url: URL) {
        let alert = UIAlertController(title: Strings.openLink, message: url.absoluteString, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: Strings.yes, style: .default) { [unowned self] (_) in
            if UIApplication.shared.canOpenURL(url) {
                let safariVC = SFSafariViewController(url: url)
                self.executorDetailsVC.present(safariVC, animated: true)
            }
            else {
                let errorAlert = UIAlertController.simpleAlert(title: Strings.invalidURL, message: nil, handler: nil)
                self.executorDetailsVC.present(errorAlert, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        executorDetailsVC.present(alert, animated: true)
    }
    
    func showOrderOptions() {
        guard let executor = currentExecutor else { return }
        let options = executor.orderSettings.filter({!$0.isBase})
        if !options.isEmpty {
            orderOptionsVC.options = options
            orderOptionsVC.executorName = executor.firstName + " " + executor.lastName
            navigationController.pushViewController(orderOptionsVC, animated: true)
        }
        else {
            showPayScreen()
        }
    }
    
    func showPayScreen() {
        guard let executor = currentExecutor, let orderPreform = orderPreform else { return }
        payVC.orderSchemeUnits = orderPreform.fields.filter { !(!$0.isRequired && $0.text.isEmpty) }
        let baseCost = Int(executor.orderSettings.filter({$0.isBase}).first?.price ?? "") ?? 0
        let selectedOptionsCost = orderPreform.selectedOptions.map{(Int($0.price) ?? 0)}.reduce(0) {$0 + $1}
        payVC.sum = (baseCost + selectedOptionsCost).string
        navigationController.pushViewController(payVC, animated: true)
    }
    
    func showPaymentDescription() {
        let string = "Payment description text"
        infoVC.text = string
        infoVC.modalPresentationStyle = .overFullScreen
        payVC.present(infoVC, animated: true, completion: nil)
    }
    
    func placeOrder(completion: @escaping () -> Void) {
        showLoadingIndicator()
        guard let orderPreform = orderPreform else { return }
        let orderDict = orderPreform.dict()
        apiService.placeOrder(orderDict: orderDict) { [unowned self] (success, errorMessage) in
            DispatchQueue.main.async {
                if let errorMessage = errorMessage {
                    self.removeLoadingIndicator()
                    self.showSimpleAlert(title: errorMessage, handler: nil)
                }
                else if success {
                    // remove this line later
                    self.removeLoadingIndicator()
                    self.showSimpleAlert(title: "Success!") {
                        self.navigateToRoot()
                    }
                    completion()
                }
            }
        }
    }
    
    func payWithApplePay() {
//        self.removeLoadingIndicator()
        print("paid with Apple Pay")
    }
    
    func payWithCard() {
//        self.removeLoadingIndicator()
        print("paid with card")
    }
    
    func navigateToRoot() {
        navigationController.popToViewController(executorsListVC, animated: true)
    }
}

extension ExecutorsTabCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == executorsListVC {
            errorVC.reload = { [unowned self] in self.getExecutors() }
        }
        else {
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.backgroundColor = UIColor.clear
            navigationController.navigationBar.isTranslucent = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == executorsListVC {
            executorDetailsVC.orderScheme = nil
            orderPreform = nil
            executorDetailsVC.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
}
