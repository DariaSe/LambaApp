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
            delegate?.sendChanges()
        }
    }
    
    var orderSettings: [OrderSettings] = []
    var isReceivingOrders: Bool = true
    
    var delegate: SettingsDelegate?
    
    let tableView = SelfSizingTableView()
    
    private let refreshControl = UIRefreshControl()
    
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
        tableView.register(OrderSettingsTableViewCell.self, forCellReuseIdentifier: OrderSettingsTableViewCell.reuseIdentifier)
        tableView.separatorInset = UIEdgeInsets.zero
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        delegate?.refresh()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [unowned self] in
            self.refreshControl.endRefreshing()
        })
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
            cell.switchIsOn = { [unowned self] bool in
                self.userInfo?.isReceivingOrders = bool
            }
        }
        else {
            let settings = orderSettings[indexPath.row]
            cell.update(with: settings)
            cell.switchIsOn = { [unowned self] bool in
                self.userInfo?.orderSettings[indexPath.row].isOn = bool
                if let price = self.userInfo?.orderSettings[indexPath.row].price,
                    (price == "" || price == "0" || price.containsInvalidCharacters()) {
                    self.delegate?.showEmptyPriceAlert()
                    self.userInfo?.orderSettings[indexPath.row].isOn = false
                    tableView.reloadData()
                }
            }
            cell.textChanged = { [unowned self] text in
                self.userInfo?.orderSettings[indexPath.row].price = text
                if text.isEmpty {
                    self.userInfo?.orderSettings[indexPath.row].isOn = false
                    self.userInfo?.orderSettings[indexPath.row].price = "0"
                    tableView.reloadData()
                }
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
            return 58
        }
        else {
            return 108
        }
    }
}
