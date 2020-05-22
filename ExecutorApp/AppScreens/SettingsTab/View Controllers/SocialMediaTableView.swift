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
            tableView.reloadData()
        }
    }
    
    private let stackView = UIStackView()
    private let descriptionLabel = UILabel()
    let tableView = UITableView()
    
    var delegate: SettingsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: self)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(descriptionLabel)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(SocialMediaTableViewCell.self, forCellReuseIdentifier: SocialMediaTableViewCell.reuseIdentifier)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = Strings.socialLinksDescription
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
        cell.textChanged = { [unowned self] text in
            self.socialMedia[indexPath.row].url = text
            self.delegate?.sendChanges()
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
