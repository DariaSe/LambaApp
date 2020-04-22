//
//  e_String.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
