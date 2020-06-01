//
//  PermissionsService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit

class PermissionsService {
    static func alertToSettings(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: Strings.settings, style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(settingsAction)
        alert.addAction(okAction)
        return alert
    }
}
