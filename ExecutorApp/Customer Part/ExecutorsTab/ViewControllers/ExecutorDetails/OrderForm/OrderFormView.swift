//
//  OrderFormView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderFormView: UIView {
    
    var orderScheme: OrderScheme?
    
    var currentSchemeIndex: Int = 0
    var currentScheme: [OrderSchemeUnit] {
        return orderScheme?.variations[currentSchemeIndex].units ?? []
    }
    
    let stackView = UIStackView()
    
    let segmentedControl = UISegmentedControl()
    let tableView = UITableView()
    
    let buttonLabelStackView = UIStackView()
    let continueButton = AppButton(title: Strings.continueString)
    let warningLabel = UILabel()
    
    var continuePressed: ((OrderScheme, Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToLayoutMargins(to: self)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(buttonLabelStackView)
        
        buttonLabelStackView.axis = .vertical
        buttonLabelStackView.spacing = 3
        buttonLabelStackView.addArrangedSubview(continueButton)
        buttonLabelStackView.addArrangedSubview(warningLabel)
        
        segmentedControl.setHeight(equalTo: 40)
        segmentedControl.tintColor = UIColor.tintColor
        
        segmentedControl.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        continueButton.setHeight(equalTo: SizeConstants.buttonHeight)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(OrderFormTableViewCell.self, forCellReuseIdentifier: OrderFormTableViewCell.reuseIdentifier)
        
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        warningLabel.font = UIFont.systemFont(ofSize: 12)
        warningLabel.textColor = UIColor.lightGray
        warningLabel.textAlignment = .center
        warningLabel.text = Strings.youDoNotPayWarning
    }
    
    @objc func segmentSelected() {
        currentSchemeIndex = segmentedControl.selectedSegmentIndex
        tableView.reloadData()
    }
    
    @objc func continueButtonPressed() {
        continueButton.animate(scale: 1.05)
        guard let orderScheme = orderScheme else { return }
        continuePressed?(orderScheme, currentSchemeIndex)
    }
    
    func setInitialData() {
        guard let orderScheme = orderScheme else { return }
        segmentedControl.removeAllSegments()
        for (index, scheme) in orderScheme.variations.enumerated() {
            segmentedControl.insertSegment(withTitle: scheme.title, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        tableView.reloadData()
    }
}

extension OrderFormView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentScheme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderFormTableViewCell.reuseIdentifier, for: indexPath) as! OrderFormTableViewCell
        let unit = currentScheme[indexPath.row]
        cell.update(with: unit)
        cell.textChanged = { [unowned self] text in
            self.orderScheme?.variations[self.currentSchemeIndex].units[indexPath.row].text = text
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        return cell
    }
}

extension OrderFormView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
