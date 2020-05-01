//
//  ReadyToTransferTableView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ReadyToTransferTableView: UIView {
    
    var units: [ReadyToTransferUnit] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView = SelfSizingTableView()
    
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
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(ReadyToTransferTableViewCell.self, forCellReuseIdentifier: ReadyToTransferTableViewCell.reuseIdentifier)
    }
    
}

extension ReadyToTransferTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReadyToTransferTableViewCell.reuseIdentifier, for: indexPath) as! ReadyToTransferTableViewCell
        let unit = units[indexPath.row]
        cell.update(title: unit.title, sum: unit.sum)
        return cell
    }
}

extension ReadyToTransferTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
