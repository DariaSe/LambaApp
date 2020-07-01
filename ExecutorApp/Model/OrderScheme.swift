//
//  OrderScheme.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderScheme {
    var variations: [OrderSchemeVariation]
    
//    static func sample() -> OrderScheme {
//        return OrderScheme(variations: [OrderSchemeVariation(position: 1, title: "Executor text", units: OrderSchemeUnit.sampleFisrt()), OrderSchemeVariation(position: 2, title: "Your text", units: OrderSchemeUnit.sampleSecond()), OrderSchemeVariation(position: 3, title: "Promo", units: OrderSchemeUnit.sampleThird())])
//    }
    
    static func initialize(from dictionary: [[String : Any]]) -> OrderScheme {
        let variations = dictionary.compactMap(OrderSchemeVariation.initialize).sorted()
        return OrderScheme(variations: variations)
    }
}

struct OrderSchemeVariation: Comparable {
    
    var position: Int
    var title: String
    var units: [OrderSchemeUnit]
    
    static func initialize(from dictionary: [String : Any]) -> OrderSchemeVariation? {
        guard let position = dictionary["position"] as? Int,
            let title = dictionary["title"] as? String,
            let fieldsDict = dictionary["fields"] as? [[String : Any]]
            else { return nil }
        let fields = fieldsDict.compactMap(OrderSchemeUnit.initialize).sorted()
        return OrderSchemeVariation(position: position, title: title, units: fields)
    }
    
    static func < (lhs: OrderSchemeVariation, rhs: OrderSchemeVariation) -> Bool {
        return lhs.position < rhs.position
    }
    
    static func == (lhs: OrderSchemeVariation, rhs: OrderSchemeVariation) -> Bool {
        return lhs.position == rhs.position
    }
}
