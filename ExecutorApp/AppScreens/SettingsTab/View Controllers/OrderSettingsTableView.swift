//
//  OrderSettingsTableView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 28.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderSettingsTableView: UIView {
    
    var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else { return }
            orderSettings = userInfo.orderSettings
            isReceivingOrders = userInfo.isReceivingOrders
            tableView.reloadData()
        }
    }
    
    var orderSettings: [OrderSettings] = []
    var isReceivingOrders: Bool = true
    
    let tableView = SelfSizingTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        tableView.pinToEdges(to: self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        tableView.register(OrderSettingsTableViewCell.self, forCellReuseIdentifier: OrderSettingsTableViewCell.reuseIdentifier)
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
}

extension OrderSettingsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderSettings.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderSettingsTableViewCell.reuseIdentifier, for: indexPath) as! OrderSettingsTableViewCell
        if indexPath.row == orderSettings.count {
            cell.updateReceiveOrders(isOn: isReceivingOrders)
            cell.switchIsOn = { [weak self] bool in
                self?.isReceivingOrders = bool
            }
        }
        else {
            let settings = orderSettings[indexPath.row]
            cell.update(with: settings)
            cell.switchIsOn = { [weak self] bool in
                self?.orderSettings[indexPath.row].isOn = bool
            }
            cell.textChanged = { [weak self] text in
                self?.orderSettings[indexPath.row].price = text
            }
        }
        return cell
    }
}

extension OrderSettingsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == orderSettings.count {
            return 50
        }
        else {
            return 100
        }
    }
}
