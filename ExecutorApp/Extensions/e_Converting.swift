//
//  e_Converting.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 03.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension Int {
    var string: String { String(self) }
    var double: Double { Double(self) }
    var float: Float { Float(self) }
    var cgFloat: CGFloat { CGFloat(self) }
    var bool: Bool? {
        if self == 0 {
            return false
        }
        else if self == 1 {
            return true
        }
        else {
            return nil
        }
    }
}

