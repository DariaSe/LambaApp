//
//  OrderStatusView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class OrderStatusView: UIView {
    
    var status: OrderStatus? {
        didSet {
            guard let status = status else { return }
            switch status {
            case .done:
                imageStatusView.status = .done
                imageStatusView.isHidden = false
                buttonsStatusView.isHidden = true
            case .active:
                imageStatusView.isHidden = true
                buttonsStatusView.isHidden = false
            case .rejectedExecutor:
                imageStatusView.status = .rejectedExecutor
                imageStatusView.isHidden = false
                buttonsStatusView.isHidden = true
            case .uploading:
                imageStatusView.status = .uploading
                imageStatusView.isHidden = false
                buttonsStatusView.isHidden = true
            case .disputeInProcess:
                imageStatusView.status = .disputeInProcess
                imageStatusView.isHidden = false
                buttonsStatusView.isHidden = true
            default:
                break
            }
        }
    }
    
    var delegate: VideoActionsDelegate?
    
    private let stackView = UIStackView()
    
    private let imageStatusView = OrderStatusImageView()
    private let buttonsStatusView = OrderStatusButtonsView()
    
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
        stackView.spacing = 12
        stackView.addArrangedSubview(buttonsStatusView)
        stackView.addArrangedSubview(imageStatusView)
        
        buttonsStatusView.uploadOptions = { [unowned self] in
            self.delegate?.showUploadOptions()
        }
        
        buttonsStatusView.reject = { [unowned self] in
            self.delegate?.reject()
        }
        
        imageStatusView.openVideo = { [unowned self] in
            self.delegate?.openVideo()
        }
    }
}
