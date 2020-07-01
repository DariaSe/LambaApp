//
//  PayViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 04.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import PassKit

class PayViewController: UIViewController {
    
    var sum: String = "" {
        didSet {
            sumLabel.text = Strings.totalCost + "\n" + sum
        }
    }
    
    var orderSchemeUnits: [OrderSchemeUnit] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var coordinator: ExecutorsTabCoordinator?
    
    let stackView = UIStackView()
    
    let servicesLabel = UILabel()
    let tableView = UITableView()
    
    let sumDescrStackView = UIStackView()
    let sumLabel = UILabel()
    let descrButton = UIButton()
    
    let applePayButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .black)
    let payWithCardButton = AppButton(title: Strings.payWithCard)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        title = Strings.payment
        view.backgroundColor = UIColor.backgroundColor
        stackView.pinToLayoutMargins(to: view)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(servicesLabel)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(sumDescrStackView)
        stackView.addArrangedSubview(applePayButton)
        stackView.addArrangedSubview(payWithCardButton)
        
        sumDescrStackView.axis = .horizontal
        sumDescrStackView.alignment = .lastBaseline
        sumDescrStackView.addArrangedSubview(sumLabel)
        sumDescrStackView.addArrangedSubview(descrButton)
        
        servicesLabel.text = Strings.services
        servicesLabel.font = UIFont.systemFont(ofSize: 28)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderFormTableViewCell.self, forCellReuseIdentifier: OrderFormTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        sumLabel.font = UIFont.systemFont(ofSize: 28)
        sumLabel.numberOfLines = 2
        
        descrButton.setSize(width: 40, height: 40)
        descrButton.layer.cornerRadius = 20
        descrButton.layer.borderWidth = 1.0
        descrButton.layer.borderColor = UIColor.tintColor.cgColor
        descrButton.setTitle("?", for: .normal)
        descrButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        descrButton.setTitleColor(UIColor.tintColor, for: .normal)
        descrButton.addTarget(self, action: #selector(descrButtonPressed), for: .touchUpInside)
        
        applePayButton.setHeight(equalTo: SizeConstants.buttonHeight)
        if #available(iOS 12.0, *) {
            applePayButton.cornerRadius = SizeConstants.buttonCornerRadius
        } else {
            payWithCardButton.layer.cornerRadius = 2
        }
        applePayButton.addTarget(self, action: #selector(applePayButtonPressed), for: .touchUpInside)

        payWithCardButton.backgroundColor = UIColor.payButtonBgColor
        payWithCardButton.layer.borderColor = UIColor.payButtonBgColor.cgColor
        payWithCardButton.addTarget(self, action: #selector(payWithCardButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func descrButtonPressed() {
        descrButton.animate(scale: 1.05)
        coordinator?.showPaymentDescription()
    }
    
    @objc func applePayButtonPressed() {
        applePayButton.animate(scale: 1.05)
        coordinator?.placeOrder { [unowned self] in
            self.coordinator?.payWithApplePay()
        }
    }
    
    @objc func payWithCardButtonPressed() {
        payWithCardButton.animate(scale: 1.05)
        coordinator?.placeOrder { [unowned self] in
            self.coordinator?.payWithCard()
        }
    }
}

extension PayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderSchemeUnits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderFormTableViewCell.reuseIdentifier, for: indexPath) as! OrderFormTableViewCell
        let unit = orderSchemeUnits[indexPath.row]
        cell.update(with: unit)
        cell.isEditable = false
        return cell
    }
}

extension PayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
