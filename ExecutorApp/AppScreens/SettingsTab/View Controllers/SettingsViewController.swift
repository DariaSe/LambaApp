//
//  SettingsViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: SettingsCoordinator?
    
    var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else { return }
            profileSettingsView.userInfo = userInfo
            orderSettingsTableView.userInfo = userInfo
        }
    }
    
    private let segmentedControl = UISegmentedControl()
    private let profileSettingsView = ProfileSettingsView()
    private let orderSettingsTableView = OrderSettingsTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications(for: profileSettingsView.scrollView)
        registerForKeyboardNotifications(for: orderSettingsTableView.tableView)
        view.backgroundColor = UIColor.backgroundColor
    
        segmentedControl.constrainTopAndBottomToLayoutMargins(of: view, leading: 20, trailing: 20, top: 10, bottom: nil)
        segmentedControl.setHeight(equalTo: 30)
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        segmentedControl.tintColor = UIColor.tintColor
        segmentedControl.insertSegment(withTitle: Strings.profileSettings, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Strings.orderSettings, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        
        profileSettingsView.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: 50, bottom: 25)
        profileSettingsView.delegate = self
      
        orderSettingsTableView.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: 50, bottom: 15)
        orderSettingsTableView.isHidden = true
        orderSettingsTableView.delegate = self

        hideKeyboardWhenTappedAround()
    }
    
    func scrollToTop() {
        profileSettingsView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sendChanges()
    }
    
    @objc func segmentSelected() {
        if segmentedControl.selectedSegmentIndex == 0 {
            profileSettingsView.isHidden = false
            orderSettingsTableView.isHidden = true
        }
        else {
            profileSettingsView.isHidden = true
            orderSettingsTableView.isHidden = false
        }
    }
    
    func setImage(_  image: UIImage?) {
        profileSettingsView.imageView.image = image
    }
}

extension SettingsViewController: SettingsDelegate {
    
    func refresh() {
        coordinator?.getUserInfo()
    }
    
    func changePhoto() {
        coordinator?.showPhotoPicker()
    }
    
    func changePassword() {
        coordinator?.showChangePasswordScreen()
    }
    
    func showEmptyPriceAlert() {
        coordinator?.showSimpleAlert(title: Strings.emptyOrderPriceAlert, handler: nil)
    }
    
    func logout() {
        coordinator?.logout()
    }
    
    func sendChanges() {
        guard let userInfo = userInfo else { return }
        let newUserInfo = UserInfo(firstName: userInfo.firstName, lastName: userInfo.lastName, email: userInfo.email,
            socialMedia: profileSettingsView.socialMediaTableView.socialMedia,
            hashtags: profileSettingsView.hashtagsView.hashtags,
            orderSettings: orderSettingsTableView.orderSettings,
            isReceivingOrders: orderSettingsTableView.isReceivingOrders, currencySign: "", role: nil)
        if userInfo != newUserInfo {
            self.userInfo = newUserInfo
            coordinator?.postUserInfo(newUserInfo)
        }
    }
}
