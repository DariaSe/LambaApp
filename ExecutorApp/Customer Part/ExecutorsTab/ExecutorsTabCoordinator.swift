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
    let executorDetailsVC = ExecutorDetailsViewController()
    
    let apiService = ExecutorsApiService()
    
    func start() {
        navigationController.navigationBar.tintColor = UIColor.textColor
        navigationController.delegate = self
        executorsListVC.coordinator = self
        executorDetailsVC.coordinator = self
        navigationController.viewControllers = [executorsListVC]
        errorVC.reload = { [unowned self] in self.getExecutors() }
        let starImage = UIImage(named: "Star")
        executorsListVC.tabBarItem = UITabBarItem(title: Strings.executors, image: starImage, tag: 0)
        executorsListVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func setImage(_ image: UIImage?) {
        executorsListVC.userImage = image
    }
    
   
    func getExecutors(search: String = "", order: String = "") {
        showLoadingIndicator()
        apiService.getExecutors(search: search, order: order) { [unowned self] (executors, errorMessage) in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
            }
            if let executors = executors {
                self.executorsListVC.executors = executors
            }
        }
    }
    
    func loadMore(search: String = "", order: String = "") {
        if apiService.isMore {
            showLoadingIndicator()
            apiService.page += 1
            apiService.getExecutors(search: search, order: order) { [unowned self] (executors, errorMessage) in
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
        executorDetailsVC.hidesBottomBarWhenPushed = true
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
                self.executorDetailsVC.executorDetails = executorDetails
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
}

extension ExecutorsTabCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == executorsListVC {
            errorVC.reload = { [unowned self] in self.getExecutors() }
        }
        else {
            errorVC.reload = { [unowned self] in self.getExecutorDetails(executorID: self.executorDetailsVC.executorDetails?.id ?? -1) }
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.backgroundColor = UIColor.clear
            navigationController.navigationBar.isTranslucent = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == executorsListVC {
            executorDetailsVC.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
}
