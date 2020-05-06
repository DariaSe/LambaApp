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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.save, style: .done, target: self, action: #selector(saveChanges))
    
        segmentedControl.constrainTopAndBottomToLayoutMargins(of: view, leading: 20, trailing: 20, top: 10, bottom: nil)
        segmentedControl.setHeight(equalTo: 30)
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        segmentedControl.tintColor = UIColor.tintColor
        segmentedControl.insertSegment(withTitle: Strings.profileSettings, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Strings.orderSettings, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        
        profileSettingsView.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: 50, bottom: 10)
        profileSettingsView.changePhoto = { [weak self] in
            self?.coordinator?.showPhotoPicker()
        }
        profileSettingsView.changePassword = { [weak self] in
            self?.coordinator?.showChangePasswordScreen()
        }
        profileSettingsView.logout = { [weak self] in
            self?.coordinator?.logout()
        }
        
        orderSettingsTableView.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: 50, bottom: 10)
        orderSettingsTableView.isHidden = true
    
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
    
    func setImage(_  image: UIImage) {
        profileSettingsView.imageView.image = image
    }
    
    @objc func saveChanges() {
        view.endEditing(true)
        let newUserInfo = UserInfo(
            image: nil,
            socialMedia: profileSettingsView.socialMediaTableView.newSocialMedia,
            hashtags: profileSettingsView.hashtagsView.newHashtags,
            orderSettings: orderSettingsTableView.orderSettings,
            isReceivingOrders: orderSettingsTableView.isReceivingOrders)
        coordinator?.postUserInfo(newUserInfo)
    }
}

//extension SettingsViewController {
//
//    func registerForKeyboardNotifications() {
//
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
//                self?.keyboardWasShown(notification)
//            }
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] _ in
//                self?.keyboardWillBeHidden()
//            }
//        }
//
//        func keyboardWasShown(_ notification: Notification) {
//            let info = notification.userInfo!
//            let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
//            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize!.height - (self.navigationController?.tabBarController?.tabBar.frame.height ?? 0), right: 0)
//            profileSettingsView.scrollView.contentInset = insets
//            profileSettingsView.scrollView.scrollIndicatorInsets = insets
//        }
//
//        func keyboardWillBeHidden() {
//            profileSettingsView.scrollView.contentInset = UIEdgeInsets.zero
//            profileSettingsView.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
//            view.endEditing(true)
//        }
//}