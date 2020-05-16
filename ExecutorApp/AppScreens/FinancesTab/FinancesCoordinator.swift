//
//  FinancesCoordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class FinancesCoordinator: Coordinator {
    
    let apiService = FinancesApiServiceMain()
    
    let financesVC = FinancesViewController()
    let infoVC = TransferDescriptionViewController()
    
    func start() {
        financesVC.coordinator = self
        errorVC.reload = { [weak self] in self?.getFinancesInfo() }
        navigationController.viewControllers = [financesVC]
        let dollarImage = UIImage(named: "DSign")
        financesVC.tabBarItem = UITabBarItem(title: Strings.finances, image: dollarImage, tag: 1)
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
                self?.infoVC.text = financesInfo.transferDescription
                
            }
            else {
                let emptyVC = ErrorViewController()
                emptyVC.message = Strings.noOrdersYet
                self?.financesVC.add(emptyVC)
            }
        }
    }
    
    func showTransferDescription() {
        infoVC.modalPresentationStyle = .overCurrentContext
        financesVC.present(infoVC, animated: true, completion: nil)
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
