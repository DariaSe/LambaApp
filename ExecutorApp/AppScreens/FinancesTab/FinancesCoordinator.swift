//
//  FinancesCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class FinancesCoordinator: Coordinator {
    
    var navigationController = UINavigationController()
    
    let apiService: FinancesApiService = FinancesApiServiceMock()
    
    lazy var loadingVC = LoadingViewController(backgroundColor: UIColor.backgroundColor)
    lazy var clearLoadingVC = LoadingViewController(backgroundColor: UIColor.clear)
    
    let financesVC = FinancesViewController()
    
    func start() {
        financesVC.coordinator = self
        navigationController.viewControllers = [financesVC]
        financesVC.tabBarItem = UITabBarItem(title: Strings.finances, image: nil, tag: 1)
        financesVC.title = Strings.finances
    }

    func getFinancesInfo() {
        financesVC.add(clearLoadingVC)
        apiService.getFinances { [weak self] (financesInfo, error) in
            self?.clearLoadingVC.remove()
            if let error = error, financesInfo == nil {
                let errorVC = ErrorViewController()
                errorVC.message = error.localizedDescription
                self?.financesVC.add(errorVC)
            }
            if let financesInfo = financesInfo, error == nil {
                self?.financesVC.financesInfo = financesInfo
            }
            else {
                let emptyVC = EmptyViewController(message: Strings.noOrdersYet)
                self?.financesVC.add(emptyVC)
            }
        }
    }
    
    func transferMoney() {
        financesVC.add(clearLoadingVC)
        apiService.transferMoney { [weak self] (success) in
            self?.clearLoadingVC.remove()
            let title = success ? Strings.transactionSuccess : Strings.transactionFailed
            let message = success ? "" : Strings.error
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                self?.getFinancesInfo()
            }
            alert.addAction(okAction)
            self?.financesVC.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func showTransferDescription() {
        let infoVC = TransferDescriptionViewController()
        infoVC.modalPresentationStyle = .overCurrentContext
        financesVC.present(infoVC, animated: true, completion: nil)
        infoVC.add(clearLoadingVC)
        apiService.getTransferDescription { [weak self] (text) in
            self?.clearLoadingVC.remove()
            if let text = text {
                infoVC.text = text
            }
            else {
                infoVC.text = Strings.error
            }
        }
    }
    
}
