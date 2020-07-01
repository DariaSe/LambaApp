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
            let baseOptionIsOn = executorDetails.orderSettings.filter({$0.isBase}).first?.isOn ?? false
            let isReceivingOrders = executorDetails.isReceivingOrders && baseOptionIsOn
            notReceivingOrdersView.isHidden = isReceivingOrders
            orderFormView.isHidden = !isReceivingOrders
            notReceivingOrdersLabel.text = Strings.notReceivingOrdersStart + executorDetails.firstName + "\n" + executorDetails.lastName + Strings.notReceivingOrdersEnd
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
        
        stackView.constrainToEdges(of: self, leading: 0, trailing: 0, top: nil, bottom: nil)
        topConstraint = stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)
        topConstraint.isActive = true
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(socialsView)
        
        orderFormView.constrainToEdges(of: self, leading: 12, trailing: 12, top: nil, bottom: 20)
        orderFormView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12).isActive = true
        notReceivingOrdersView.constrainToEdges(of: self, leading: 30, trailing: 30, top: nil, bottom: nil)
        notReceivingOrdersView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 45).isActive = true
        notReceivingOrdersView.setHeight(equalTo: 150)
        notReceivingOrdersView.layer.cornerRadius = 15
        notReceivingOrdersView.backgroundColor = UIColor.textControlsBackgroundColor
        notReceivingOrdersLabel.center(in: notReceivingOrdersView)
        notReceivingOrdersLabel.textAlignment = .center
        notReceivingOrdersLabel.numberOfLines = 3
        notReceivingOrdersLabel.font = UIFont.systemFont(ofSize: 18)
        
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 28)
        socialsView.setWidth(equalTo: 150)
        socialsView.setHeight(equalTo: 40)
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
