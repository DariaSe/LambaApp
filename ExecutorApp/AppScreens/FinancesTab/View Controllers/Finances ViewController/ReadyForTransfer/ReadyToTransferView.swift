//
//  ReadyToTransferView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ReadyToTransferView: UIView {
    
    var financesInfo: FinancesInfo? {
        didSet {
            guard let financesInfo = financesInfo else { return }
            tableViewContainer.units = financesInfo.readyToTransferUnits
            sumView.text = financesInfo.sum
        }
    }
    
    private let stackView = UIStackView()
    
    private let titleLabel = UILabel()
    private let tableViewContainer = ReadyToTransferTableView()
    
    private let separatorView = UIView()
    
    private let sumStackView = UIStackView()
    private let sumTitleLabel = UILabel()
    private let sumView = SumView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow(height: 2, shadowRadius: 3, opacity: 0.1, cornerRadius: 20)
    }
    
    private func initialSetup() {
        layer.cornerRadius = 20
        backgroundColor = UIColor.readyToTransferBgColor
        
        stackView.pinToLayoutMargins(to: self, constant: 10)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tableViewContainer)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(sumStackView)
        
        sumStackView.axis = .horizontal
        sumStackView.alignment = .fill
        sumStackView.setWidth(equalTo: stackView)
        sumStackView.addArrangedSubview(sumTitleLabel)
        sumStackView.addArrangedSubview(sumView)
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.text = Strings.readyForTransfer
        
        separatorView.setHeight(equalTo: 1.0)
        separatorView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        
        sumTitleLabel.textAlignment = .left
        sumTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sumTitleLabel.text = Strings.total
       
        sumView.setHeight(equalTo: SizeConstants.sumViewHeight)
        sumView.setWidth(equalTo: 120)
    }
}
