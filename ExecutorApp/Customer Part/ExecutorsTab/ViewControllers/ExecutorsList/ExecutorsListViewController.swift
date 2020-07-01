//
//  ExecutorsListViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorsListViewController: UIViewController {
    
    weak var coordinator: ExecutorsTabCoordinator?
    
    var executors: [Executor] = [] {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
  
    var userImage: UIImage? {
        didSet {
            userButton.userImage = userImage
        }
    }
    
   
    let searchBar = AppSearchBar()
    
    let sortingView = ExecutorsSortingView()
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    let userButton = UserButton()
    weak var delegate: UserButtonDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = UIColor.backgroundColor
        
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = true
        
        navigationItem.rightBarButtonItem = userButton
        userButton.userTapped = { [unowned self] in self.delegate?.showSettings() }
        
        sortingView.constrainTopAndBottomToLayoutMargins(of: view, leading: 12, trailing: 0, top: 10, bottom: nil)
        sortingView.setHeight(equalTo: 40)
        sortingView.didSelectOption = { [unowned self] option in
            self.coordinator?.sortingOption = option
        }
        
        tableView.constrainTopAndBottomToLayoutMargins(of: view, leading: 12, trailing: 12, top: 60, bottom: 15)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(ExecutorTableViewCell.self, forCellReuseIdentifier: ExecutorTableViewCell.reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.view.setNeedsLayout()
        navigationController?.view.layoutIfNeeded()
    }
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        coordinator?.refresh()
    }
}

extension ExecutorsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return executors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExecutorTableViewCell.reuseIdentifier, for: indexPath) as! ExecutorTableViewCell
        cell.leftImageView.image = nil
        let executor = executors[indexPath.row]
        cell.update(with: executor)
        cell.favoritePressed = { [unowned self] in
            self.coordinator?.setFavorite(executorID: executor.id)
        }
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, let lastPath = indexPathsForVisibleRows.last {
            if lastPath.row == (executors.count - 1) && indexPathsForVisibleRows.count < executors.count {
                coordinator?.loadMore()
            }
        }
        return cell
    }
}

extension ExecutorsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.getExecutorDetails(executorID: executors[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}

extension ExecutorsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        coordinator?.searchString = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            coordinator?.searchString = text
        }
        searchBar.resignFirstResponder()
    }
}
