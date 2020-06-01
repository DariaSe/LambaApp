//
//  ExecutorDetailsView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorDetailsView: UIView {
    
    var executorDetails: ExecutorDetails? {
        didSet {
            guard let executorDetails = executorDetails else { return }
            nameLabel.text = executorDetails.firstName + " " + executorDetails.lastName
            socialsView.socials = executorDetails.socialMedia
            orderFormView.orderScheme = OrderScheme.sample()
            orderFormView.setInitialData()
        }
    }
    
    let stackView = UIStackView()
    
    let nameLabel = UILabel()
    
    let socialsView = SocialsCollectionView()
    
    let notReceivingOrdersView = UIView()
    let notReceivingOrdersLabel = UILabel()
    
    let orderFormView = OrderFormView()
    
    var topConstraint: NSLayoutConstraint!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        backgroundColor = UIColor.backgroundColor
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 20
        
        stackView.constrainToEdges(of: self, leading: 0, trailing: 0, top: nil, bottom: 30)
        topConstraint = stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)
        topConstraint.isActive = true
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(socialsView)
        stackView.addArrangedSubview(orderFormView)
        
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 28)
        socialsView.setWidth(equalTo: 150)
        socialsView.setHeight(equalTo: 40)
        
        orderFormView.setWidth(equalTo: stackView, multiplier: 0.95)
    }
    
    func setFullScreenMode() {
        socialsView.isHidden = true
        stackView.spacing = 20
        topConstraint.constant = 50
    }
    
    func setOverlayMode() {
        socialsView.isHidden = false
        stackView.spacing = 12
        topConstraint.constant = 30
    }
}
