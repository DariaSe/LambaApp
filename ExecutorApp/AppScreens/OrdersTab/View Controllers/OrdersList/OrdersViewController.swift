//
//  OrdersViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    weak var coordinator: ExecutorOrdersCoordinator?
    
    var userImage: UIImage? {
        didSet {
            userButton.userImage = userImage
        }
    }
    
    var orders: [Order] = [] {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    let notAcceptingView = AcceptWarningView()
    let notAcceptingViewHeight = 60
    var notAcceptingViewHeightConstraint: NSLayoutConstraint!
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    let userButton = UserButton()
    weak var delegate: UserButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        navigationItem.rightBarButtonItem = userButton
        userButton.setSize(CGSize(width: 40, height: 40))
        tableView.constrainTopAndBottomToLayoutMargins(of: view, leading: 4, trailing: 4, top: 4, bottom: nil)
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        tableViewBottomConstraint.isActive = true
        notAcceptingView.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: nil, bottom: 20)
        notAcceptingViewHeightConstraint = notAcceptingView.heightAnchor.constraint(equalToConstant: 0)
        notAcceptingViewHeightConstraint.isActive = true
        notAcceptingView.whyPressed = { [unowned self] in
            self.coordinator?.showNotReceivingOrdersDescription()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        userButton.userTapped = { [unowned self] in self.delegate?.showSettings() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let userInfo = InfoService.shared.userInfo else { return }
        let receiveOrders = userInfo.isReceivingOrders
        tableViewBottomConstraint.constant = receiveOrders ? -10 : -70
        notAcceptingViewHeightConstraint.constant = receiveOrders ? 0 : 60
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
        cell.update(with: order, userRole: .executor)
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, let lastPath = indexPathsForVisibleRows.last {
            if lastPath.row == (orders.count - 1) && indexPathsForVisibleRows.count < orders.count {
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
        return 82
    }
}
