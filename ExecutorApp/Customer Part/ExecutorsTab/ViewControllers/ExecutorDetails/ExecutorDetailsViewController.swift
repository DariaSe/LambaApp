//
//  ExecutorDetailsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorDetailsViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: ExecutorsTabCoordinator?
    
    var executorDetails: ExecutorDetails? {
        didSet {
            guard let executorDetails = executorDetails else { return }
            if let url = URL(string: executorDetails.imageURLString) {
                photoImageView.downloadImageFrom(url: url)
            }
            else {
                photoImageView.image = InfoService.shared.placeholderImage
            }
            favoriteButton.tintColor = executorDetails.isFavorite ? UIColor.destructiveColor : UIColor.lightGray
            detailsView.executorDetails = executorDetails
        }
    }
    
    var orderScheme: OrderScheme? {
        didSet {
            detailsView.orderFormView.orderScheme = orderScheme
            detailsView.orderFormView.setInitialData()
        }
    }
    
    let photoImageView = UIImageView()
    let shadowingView = UIView()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let dummyView = UIView()
    
    let detailsView = ExecutorDetailsView()
    
    var detailsViewTopConstraint: NSLayoutConstraint!
    var detailsViewBottomConstraint: NSLayoutConstraint!
    
    let constrConstant = UIScreen.main.bounds.width - 50
    
    var didAppear: Bool = false
    
    let favoriteButton = UIButton()
    private let heart = UIImage(named: "Heart")?.withRenderingMode(.alwaysTemplate)

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications(for: detailsView.orderFormView.tableView)
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.backgroundColor
        photoImageView.constrainToEdges(of: view, leading: 0, trailing: 0, top: 0, bottom: nil)
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor).isActive = true
        photoImageView.contentMode = .scaleAspectFill
        shadowingView.constrainToEdges(of: view, leading: 0, trailing: 0, top: 0, bottom: nil)
        shadowingView.heightAnchor.constraint(equalTo: shadowingView.widthAnchor).isActive = true

        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.pinToEdges(to: view)
        scrollView.setWidth(equalTo: view)
        stackView.pinToEdges(to: scrollView)
        stackView.setWidth(equalTo: view)
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.addArrangedSubview(dummyView)
        stackView.addArrangedSubview(detailsView)
        dummyView.setHeight(equalTo: constrConstant)
        detailsView.setHeight(equalTo: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
        detailsView.socialsView.openURL = { [unowned self] url in
            self.coordinator?.openURL(url: url)
        }
        detailsView.orderFormView.didBeginEditing = { [unowned self] in
            if self.didAppear {
                self.scrollView.contentOffset.y = self.constrConstant
            }
        }
        
        detailsView.orderFormView.continuePressed = { [unowned self] orderScheme, index in
            self.coordinator?.orderPreform?.variation = index
            self.coordinator?.orderPreform?.fields = orderScheme.variations[index].units
            self.coordinator?.showOrderOptions()
        }
        
        favoriteButton.constrainToEdges(of: detailsView, leading: nil, trailing: 25, top: -20, bottom: nil)
        favoriteButton.setSize(width: 44, height: 44)
        favoriteButton.backgroundColor = .white
        favoriteButton.layer.cornerRadius = 22
        favoriteButton.clipsToBounds = true
        favoriteButton.setImage(heart, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteButton.dropShadow(height: 0, shadowRadius: 6, opacity: 0.25, cornerRadius: 22)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        didAppear = false
    }

    @objc func favoriteButtonPressed() {
        guard let executorDetails = executorDetails else { return }
        favoriteButton.animate(scale: 1.1)
        coordinator?.setFavorite(executorID: executorDetails.id)
    }
}


extension ExecutorDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let shadowOpacity = (scrollView.contentOffset.y + 88) / (constrConstant * 2)
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(shadowOpacity)
        print(scrollView.contentOffset)
        if scrollView.contentOffset.y >= constrConstant {
            favoriteButton.isHidden = true
            detailsView.setFullScreenMode()
        }
        else {
            favoriteButton.isHidden = false
            detailsView.setOverlayMode()
        }
        print(scrollView.contentOffset)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
