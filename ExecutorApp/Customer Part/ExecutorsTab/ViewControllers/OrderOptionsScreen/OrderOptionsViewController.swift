//
//  OrderOptionsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderOptionsViewController: UIViewController {
    
    weak var coordinator: ExecutorsTabCoordinator?
    
    var options: [OrderSettings] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedOptions: [OrderSettings] = []
    
    var executorName: String?
    
    let stackView = UIStackView()
    
    let tableView = UITableView()
    
    let buttonLabelStackView = UIStackView()
    let continueButton = AppButton(title: Strings.continueString)
    let warningLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        title = Strings.options
        stackView.pinToLayoutMargins(to: view)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(buttonLabelStackView)
        
        buttonLabelStackView.axis = .vertical
        buttonLabelStackView.spacing = 3
        buttonLabelStackView.addArrangedSubview(continueButton)
        buttonLabelStackView.addArrangedSubview(warningLabel)
        
        warningLabel.font = UIFont.systemFont(ofSize: 12)
        warningLabel.textColor = UIColor.lightGray
        warningLabel.textAlignment = .center
        warningLabel.text = Strings.youDoNotPayWarning
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(OrderOptionTableViewCell.self, forCellReuseIdentifier: OrderOptionTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }
    
    @objc func continueButtonPressed() {
        continueButton.animate(scale: 1.05)
        coordinator?.orderPreform?.selectedOptions = selectedOptions
        coordinator?.showPayScreen()
    }
}

extension OrderOptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderOptionTableViewCell.reuseIdentifier, for: indexPath) as! OrderOptionTableViewCell
        cell.update(with: options[indexPath.row], name: executorName)
        cell.switchValueChanged = { [unowned self] isOn in
            if isOn {
                self.selectedOptions.append(self.options[indexPath.row])
            }
            else {
                self.selectedOptions.removeAll { $0 == self.options[indexPath.row] }
            }
        }
        return cell
    }
}

extension OrderOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
