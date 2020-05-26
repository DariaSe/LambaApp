//
//  ExecutorsTabCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorsTabCoordinator: Coordinator {
    
    let executorsListVC = ExecutorsListViewController()
    let executorDetailsVC = ExecutorDetailsViewController()
    
    let apiService = ExecutorsApiService()
    
    func start() {
        executorsListVC.coordinator = self
        navigationController.viewControllers = [executorsListVC]
        errorVC.reload = { [unowned self] in self.getExecutors() }
        let starImage = UIImage(named: "Star")
        executorsListVC.tabBarItem = UITabBarItem(title: Strings.executors, image: starImage, tag: 0)
    }
    
    func setImage(_ image: UIImage?) {
        executorsListVC.userImage = image
    }
    
   
    func getExecutors(search: String = "", order: String = "") {
        showLoadingIndicator()
        apiService.getExecutors(search: search, order: order) { [unowned self] (executors, imageURLs, errorMessage) in
            self.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self.showFullScreenError(message: errorMessage)
            }
            if let executors = executors {
                self.executorsListVC.executors = executors
            }
            if let imageURLs = imageURLs {
                self.executorsListVC.imageURLs = imageURLs
            }
        }
    }
    
    func loadMore(search: String = "", order: String = "") {
        if apiService.isMore {
            showLoadingIndicator()
            apiService.page += 1
            apiService.getExecutors(search: search, order: order) { [unowned self] (executors, imageURLs, errorMessage) in
                self.removeLoadingIndicator()
                if let errorMessage = errorMessage {
                    self.showPopUpError(message: errorMessage)
                }
                if let executors = executors {
                    self.executorsListVC.executors.append(contentsOf: executors)
                }
                if let imageURLs = imageURLs {
                    self.executorsListVC.imageURLs.append(contentsOf: imageURLs)
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
                }
                if let errorMessage = errorMessage {
                    self.showPopUpError(message: errorMessage)
                }
            }
        }
    }
    
    func showExecutor(executorID: Int) {
        navigationController.pushViewController(executorDetailsVC, animated: true)
    }
}

