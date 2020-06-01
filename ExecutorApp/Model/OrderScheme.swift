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
    
    static func sample() -> OrderScheme {
        return OrderScheme(variations: [OrderSchemeVariation(title: "Executor text", units: OrderSchemeUnit.sampleFisrt()), OrderSchemeVariation(title: "Your text", units: OrderSchemeUnit.sampleSecond()), OrderSchemeVariation(title: "Promo", units: OrderSchemeUnit.sampleThird())])
    }
}

struct OrderSchemeVariation {
    var title: String
    var units: [OrderSchemeUnit]
}
