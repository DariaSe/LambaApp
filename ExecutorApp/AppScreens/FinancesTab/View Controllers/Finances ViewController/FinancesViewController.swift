//
//  FinancesViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class FinancesViewController: UIViewController {
    
    weak var coordinator: FinancesCoordinator?
    
    var financesInfo: FinancesInfo? {
        didSet {
            guard let financesInfo = financesInfo else { return }
            readyForTransferView.financesInfo = financesInfo
            unexecutedView.sum = financesInfo.notReadySum
            if financesInfo.readyToTransferUnits.isEmpty {
                readyForTransferView.isHidden = true
                bottomElementsStackView.isHidden = true
            }
            else {
                readyForTransferView.isHidden = false
                bottomElementsStackView.isHidden = false
            }
        }
    }
    
    private let stackView = UIStackView()
    
    private let scrollView = UIScrollView()
    private let moneyViewsStackView = UIStackView()

    private let readyForTransferView = ReadyToTransferView()
    private let unexecutedView = UnexecutedOrdersSumView()
    
    private let bottomElementsStackView = UIStackView()
    private let descrStackView = UIStackView()
    private let descrLabel = UILabel()
    private let descrButton = UIButton()
    private let transferButton = AppButton()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        stackView.constrainToLayoutMargins(of: view, leading: 10, trailing: 10, top: 10, bottom: 25)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(bottomElementsStackView)
        scrollView.setWidth(equalTo: stackView)
        scrollView.clipsToBounds = false
        
        moneyViewsStackView.pinToEdges(to: scrollView)
        moneyViewsStackView.setWidth(equalTo: scrollView)
        moneyViewsStackView.axis = .vertical
        moneyViewsStackView.spacing = 10
        moneyViewsStackView.addArrangedSubview(readyForTransferView)
        moneyViewsStackView.addArrangedSubview(unexecutedView)
        
        bottomElementsStackView.axis = .vertical
        bottomElementsStackView.spacing = 10
        bottomElementsStackView.addArrangedSubview(descrStackView)
        bottomElementsStackView.addArrangedSubview(transferButton)
        
        descrStackView.axis = .horizontal
        descrStackView.addArrangedSubview(descrLabel)
        descrStackView.addArrangedSubview(descrButton)
        
        descrLabel.textAlignment = .center
        descrLabel.text = Strings.transferAllowed
        descrLabel.font = UIFont.systemFont(ofSize: 16)
        
        descrButton.setWidth(equalTo: 30)
        descrButton.setHeight(equalTo: 30)
        descrButton.layer.cornerRadius = 15
        descrButton.layer.borderWidth = 1.0
        descrButton.layer.borderColor = UIColor.tintColor.cgColor
        descrButton.setTitleColor(UIColor.tintColor, for: .normal)
        descrButton.setTitle("?", for: .normal)
        descrButton.addTarget(self, action: #selector(descriptionButtonPressed), for: .touchUpInside)
        
        transferButton.setTitle(Strings.transferMoney, for: .normal)
        transferButton.setHeight(equalTo: SizeConstants.buttonHeight)
        transferButton.addTarget(self, action: #selector(transferButtonPressed), for: .touchUpInside)
        
        scrollView.indicatorStyle = .black
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        coordinator?.getFinancesInfo()
        scrollView.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.getFinancesInfo()
    }
    
    @objc func transferButtonPressed() {
        transferButton.animate(scale: 1.05)
        coordinator?.transferMoney()
    }
    
    @objc func descriptionButtonPressed() {
        coordinator?.showTransferDescription()
    }

}
