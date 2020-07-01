//
//  OrderSchemeUnit.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderSchemeUnit: Comparable {
    var id: Int
    var position: Int
    var title: String
    var placeholder: String?
    var text: String
    var isRequired: Bool
    
//    static func sampleFisrt() -> [OrderSchemeUnit] {
//        let fieldOne = OrderSchemeUnit(position: 1, title: "Reason", placeholder: "Enter reason", text: "", isRequired: false)
//        let fieldTwo = OrderSchemeUnit(position: 2, title: "Person age", placeholder: "Enter age", text: "", isRequired: true)
//        let fieldThree = OrderSchemeUnit(position: 3, title: "Additional text", placeholder: "Enter text", text: "", isRequired: false)
//        return [fieldOne, fieldTwo, fieldThree]
//    }
//
//    static func sampleSecond() -> [OrderSchemeUnit] {
//        let fieldOne = OrderSchemeUnit(position: 1, title: "To whom", placeholder: "Enter name", text: "", isRequired: false)
//        let fieldTwo = OrderSchemeUnit(position: 2, title: "Person age", placeholder: "Enter age", text: "", isRequired: false)
//        let fieldThree = OrderSchemeUnit(position: 3, title: "What should be in video", placeholder: "Enter text", text: "", isRequired: true)
//        return [fieldOne, fieldTwo, fieldThree]
//    }
//
//    static func sampleThird() -> [OrderSchemeUnit] {
//        let fieldOne = OrderSchemeUnit(position: 1, title: "What to promote", placeholder: "Promo object", text: "", isRequired: true)
//        let fieldTwo = OrderSchemeUnit(position: 2, title: "Promo materials", placeholder: "Link to promo", text: "", isRequired: false)
//        let fieldThree = OrderSchemeUnit(position: 3, title: "What should be in video", placeholder: "Enter text", text: "", isRequired: false)
//        return [fieldOne, fieldTwo, fieldThree]
//    }
    
    
    static func initialize(from dictionary: [String : Any]) -> OrderSchemeUnit? {
        guard let id = dictionary["id"] as? Int,
            let position = dictionary["position"] as? Int,
            let title = dictionary["title"] as? String,
            let value = dictionary["value"] as? String,
            let isRequiredInt = dictionary["isRequired"] as? Int,
            let isRequired = isRequiredInt.bool else { return nil }
        return OrderSchemeUnit(id: id, position: position, title: title, placeholder: value, text: "", isRequired: isRequired)
    }
    
    func dict() -> [String : Any] {
        var dict = [String : Any]()
        dict["id"] = self.id
        dict["title"] = self.title
        dict["value"] = self.text
        dict["position"] = self.position
        dict["isRequired"] = self.isRequired ? 1 : 0
        return dict
    }
    
    static func < (lhs: OrderSchemeUnit, rhs: OrderSchemeUnit) -> Bool {
        return lhs.position < rhs.position
    }
    
    static func == (lhs: OrderSchemeUnit, rhs: OrderSchemeUnit) -> Bool {
        return lhs.position == rhs.position
    }
}
