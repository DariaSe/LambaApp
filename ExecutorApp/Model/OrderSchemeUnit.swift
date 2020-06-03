//
//  OrderSchemeUnit.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderSchemeUnit {
    var position: Int
    var title: String
    var placeholder: String?
    var text: String
    var isRequired: Bool
    
    static func sampleFisrt() -> [OrderSchemeUnit] {
        let fieldOne = OrderSchemeUnit(position: 1, title: "Reason", placeholder: "Enter reason", text: "", isRequired: false)
        let fieldTwo = OrderSchemeUnit(position: 2, title: "Person age", placeholder: "Enter age", text: "", isRequired: true)
        let fieldThree = OrderSchemeUnit(position: 3, title: "Additional text", placeholder: "Enter text", text: "", isRequired: false)
        return [fieldOne, fieldTwo, fieldThree]
    }
    
    static func sampleSecond() -> [OrderSchemeUnit] {
        let fieldOne = OrderSchemeUnit(position: 1, title: "To whom", placeholder: "Enter name", text: "", isRequired: false)
        let fieldTwo = OrderSchemeUnit(position: 2, title: "Person age", placeholder: "Enter age", text: "", isRequired: false)
        let fieldThree = OrderSchemeUnit(position: 3, title: "What should be in video", placeholder: "Enter text", text: "", isRequired: true)
        return [fieldOne, fieldTwo, fieldThree]
    }
    
    static func sampleThird() -> [OrderSchemeUnit] {
        let fieldOne = OrderSchemeUnit(position: 1, title: "What to promote", placeholder: "Promo object", text: "", isRequired: true)
        let fieldTwo = OrderSchemeUnit(position: 2, title: "Promo materials", placeholder: "Link to promo", text: "", isRequired: false)
        let fieldThree = OrderSchemeUnit(position: 3, title: "What should be in video", placeholder: "Enter text", text: "", isRequired: false)
        return [fieldOne, fieldTwo, fieldThree]
    }
    
}
