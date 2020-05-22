//
//  e_UIButton.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init()
        setTitle(title, for: .normal)
    }
}
