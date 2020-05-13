//
//  FinancesCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class FinancesCoordinator: Coordinator {
    
    let apiService: FinancesApiService = FinancesApiServiceMain()
    
    let financesVC = FinancesViewController()
    
    func start() {
        financesVC.coordinator = self
        errorVC.reload = { [weak self] in self?.getFinancesInfo() }
        navigationController.viewControllers = [financesVC]
        financesVC.tabBarItem = UITabBarItem(title: Strings.finances, image: nil, tag: 1)
        financesVC.title = Strings.finances
    }

    func getFinancesInfo() {
        showLoadingIndicator()
        apiService.getFinances { [weak self] (financesInfo, errorMessage) in
            self?.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                self?.showFullScreenError(message: errorMessage)
            }
            if let financesInfo = financesInfo {
                self?.removeFullScreenError()
                self?.financesVC.financesInfo = financesInfo
            }
            else {
                let emptyVC = ErrorViewController()
                emptyVC.message = Strings.noOrdersYet
                self?.financesVC.add(emptyVC)
            }
        }
    }
    
    func showTransferDescription() {
        let infoVC = TransferDescriptionViewController()
        infoVC.modalPresentationStyle = .overCurrentContext
        financesVC.present(infoVC, animated: true, completion: nil)
        showLoadingIndicator()
        apiService.getTransferDescription { [weak self] text, errorMessage in
            self?.removeLoadingIndicator()
            if let errorMessage = errorMessage {
                infoVC.text = errorMessage
            }
            if let text = text {
                infoVC.text = text
            }
            else {
                infoVC.text = Strings.error
            }
        }
    }
    
    func transferMoney() {
        showLoadingIndicator()
        apiService.transferMoney { [weak self] success, errorMessage in
            self?.removeLoadingIndicator()
            let title = success ? Strings.transactionSuccess : Strings.transactionFailed
            let message = success ? "" : Strings.error
            let alert = UIAlertController.simpleAlert(title: title, message: message) { [weak self] (_) in
                self?.getFinancesInfo()
            }
            self?.financesVC.present(alert, animated: true, completion: nil)
        }
    }
}
