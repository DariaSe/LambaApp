//
//  e_UIButton.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIButton {
    func animate(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}
