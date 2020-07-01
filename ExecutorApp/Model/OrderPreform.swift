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
    
    func dict() -> [String : Any] {
        var dict = [String : Any]()
        dict["executorId"] = self.executorID
        dict["fields"] = fields.map { $0.dict() }
        dict["options"] = selectedOptions.compactMap { $0.optionID }
        dict["orderTypeId"] = variation + 1
        return dict
    }
}
