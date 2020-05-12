//
//  OrdersViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    weak var coordinator: OrdersCoordinator?
    
    var orders: [Order] = [] {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        tableView.pinToEdges(to: view)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        coordinator?.refresh()
    }
    
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.reuseIdentifier, for: indexPath) as! OrderTableViewCell
        let order = orders[indexPath.row]
        cell.update(with: order)
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows {
            if indexPath.row == (orders.count - 1) && indexPathsForVisibleRows.count < orders.count {
                coordinator?.loadMore()
            }
        }
        return cell
    }
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showOrderDetails(orderID: orders[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
