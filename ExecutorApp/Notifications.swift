//
//  Notifications.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 18.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class NotificationService {
    static let userImageNName = NSNotification.Name(rawValue: "UserImage")
    static func postUserImageNotification() {
        NotificationCenter.default.post(name: userImageNName, object: nil)
    }
}
