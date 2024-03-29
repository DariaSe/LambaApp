//
//  OrderDetailUnit.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderDetailUnit {
    
    var position: Int
    var title: String
    var text: String
    
    static func samples() -> [OrderDetailUnit] {
        return [OrderDetailUnit(position: 1, title: "What to promote", text: "Dog toy"), OrderDetailUnit(position: 2, title: "Link", text: "google.com"), OrderDetailUnit(position: 3, title: "Text", text: "From executor"), OrderDetailUnit(position: 4, title: "Options", text: "Post to Stories")]
    }
    
    static func initialize(from dictionary: [String : Any]) -> OrderDetailUnit? {
        guard let position = dictionary["position"] as? Int,
        let title = dictionary["title"] as? String,
        let value = dictionary["value"] as? String
            else { return nil }
        let unit =  OrderDetailUnit(position: position, title: title, text: value)
        return unit
    }
}

extension OrderDetailUnit: Comparable {
    static func < (lhs: OrderDetailUnit, rhs: OrderDetailUnit) -> Bool {
        return lhs.position < rhs.position
    }
}
