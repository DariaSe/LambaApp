//
//  OrderPreform.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 10.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderPreform {
    var executorID: Int
    var variation: Int = 0
    var fields: [OrderSchemeUnit] = []
    var selectedOptions: [OrderSettings] = []
}
