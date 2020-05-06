//
//  SocialMediaTableView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SocialMediaTableView: UIView {
    
    var socialMedia: [SocialMedia] = [] {
        didSet {
            newSocialMedia = socialMedia
            tableView.reloadData()
        }
    }
    
    var newSocialMedia: [SocialMedia] = []
    
    let tableView = UITableView()
    
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
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(SocialMediaTableViewCell.self, forCellReuseIdentifier: SocialMediaTableViewCell.reuseIdentifier)
    }
}

extension SocialMediaTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SocialMediaTableViewCell.reuseIdentifier, for: indexPath) as! SocialMediaTableViewCell
        let socialMediaUnit = socialMedia[indexPath.row]
        cell.update(with: socialMediaUnit)
        cell.textChanged = { [weak self] text in
            self?.newSocialMedia[indexPath.row].url = text
        }
        return cell
    }
}


extension SocialMediaTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}