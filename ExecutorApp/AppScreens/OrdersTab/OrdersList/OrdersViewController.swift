//
//  OrdersViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    var orders: [Order] = Order.sampleOrders()
    
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
       
        refreshControl.addTarget(self, action: #selector(refresh), for: .touchDragInside)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        // send request to server
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
        if indexPath.row == (orders.count - 1) {
            // load more here
        }
        return cell
    }
    
    
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
