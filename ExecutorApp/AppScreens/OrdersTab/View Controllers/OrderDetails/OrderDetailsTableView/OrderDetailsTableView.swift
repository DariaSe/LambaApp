//
//  OrderDetailsTableView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderDetailsTableView: UIView {
    
    var orderDetailUnits: [OrderDetailUnit] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialSetup() {
        tableView.pinToEdges(to: self)
        tableView.register(OrderDetailTableViewCell.self, forCellReuseIdentifier: OrderDetailTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension OrderDetailsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailUnits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.reuseIdentifier, for: indexPath) as! OrderDetailTableViewCell
        let unit = orderDetailUnits[indexPath.row]
        cell.update(with: unit)
        return cell
    }
    
    
}

extension OrderDetailsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
