//
//  e_UIAlertController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func simpleAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        return alert
    }
}
