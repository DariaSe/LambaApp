//
//  OrderSettings.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderSettings {
    var id: Int?
    var optionID: Int
    var title: String
    var price: String
    var isOn: Bool
    var currencySign: String
    
    static func sample() -> [OrderSettings] {
        return [OrderSettings(id: 1, optionID: 1, title: "Can post to stories", price: "2000", isOn: true, currencySign: "₽"), OrderSettings(id: 2, optionID: 2, title: "Can post to feed", price: "4000", isOn: true, currencySign: "₽"), OrderSettings(id: 3, optionID: 3, title: "Can make videocall", price: "8000", isOn: false, currencySign: "₽"), OrderSettings(id: 4, optionID: 4, title: "My text", price: "15000", isOn: true, currencySign: "₽")]
    }
    
    static func initialize(from dictionary: Dictionary<String, Any>) -> OrderSettings? {
        guard
            let costs = dictionary["costs"] as? Int,
            let option = dictionary["option"] as? [String : Any],
            let optionID = option["id"] as? Int,
            let title = option["title"] as? String,
            let isOnInt = dictionary["isActive"] as? Int,
            let isOn = isOnInt.bool
            else { return nil }
        let id = dictionary["id"] as? Int
        return OrderSettings(id: id, optionID: optionID, title: title, price: costs.string, isOn: isOn, currencySign: "")
    }
    
    func dict() -> [String : Any] {
        var dict = [String : Any]()
        dict["id"] = self.id
        dict["costs"] = !self.price.isEmpty ? self.price : "0"
        dict["isActive"] = self.isOn ? 1 : 0
        let option = ["id" : self.optionID]
        dict["option"] = option
        return dict
    }
}
