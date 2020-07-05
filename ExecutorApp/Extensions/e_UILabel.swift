//
//  e_UILabel.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UILabel {
    func addAsterisk() {
        let attrText = NSMutableAttributedString(string: self.text ?? "")
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.destructiveColor]
        let asterisk = NSAttributedString(string: "*", attributes: attributes)
        attrText.append(asterisk)
        self.attributedText = attrText
    }
}
