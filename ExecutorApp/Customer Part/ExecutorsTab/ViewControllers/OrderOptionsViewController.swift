//
//  OrderOptionsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderOptionsViewController: UIViewController {
    
    var options: [OrderSettings] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let stackView = UIStackView()
    
    let tableView = UITableView()
    
    let buttonLabelStackView = UIStackView()
    let continueButton = AppButton(title: Strings.continueString)
    let warningLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}

extension OrderOptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderOptionTableViewCell.reuseIdentifier, for: indexPath) as! OrderOptionTableViewCell
        cell.update(with: options[indexPath.row])
        cell.switchValueChanged = { [unowned self] in
            
        }
        return cell
    }
}

extension OrderOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
