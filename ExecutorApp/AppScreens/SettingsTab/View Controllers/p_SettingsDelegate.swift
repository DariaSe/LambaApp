//
//  p_SettingsDelegate.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 08.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

protocol SettingsDelegate {
    func changePhoto()
    func changePassword()
    func logout()
    func sendChanges()
    func refresh()
    func showEmptyPriceAlert()
}
