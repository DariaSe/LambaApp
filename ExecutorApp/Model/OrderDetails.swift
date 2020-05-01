//
//  OrderDetails.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

enum OrderType: Int {
    case executorText = 1
    case customerText
    case promo
}

struct OrderDetails {
    var id: Int
    var type: OrderType
    var cost: String
    var currency: String
    var units: [OrderDetailUnit]
    var status: OrderStatus
    
    static func sample() -> OrderDetails {
        return OrderDetails(id: 1, type: .promo, cost: "2000", currency: "$", units: [OrderDetailUnit(title: "What to promote", data: "Dog toy"), OrderDetailUnit(title: "Link", data: "google.com"), OrderDetailUnit(title: "Text", data: "From executor"), OrderDetailUnit(title: "Options", data: "Post to Stories")], status: .active)
    }
    
    static func initialize(from dictionary: [String : Any]) -> OrderDetails? {
        guard
            let id = dictionary["id"] as? Int,
            let orderTypeInt = dictionary["orderType"] as? Int,
            let orderType = OrderType(rawValue: orderTypeInt),
            let statusString = dictionary["status"] as? String,
            let orderStatus = Order.status(from: statusString),
            let currencyDict = dictionary["currency"] as? [String : Any],
            let currencySign = currencyDict["sign"] as? String,
            let cost = dictionary["costs"] as? Int else { return nil }

        let orderDetails = OrderDetails(id: id, type: orderType, cost: String(cost), currency: currencySign, units: [], status: orderStatus)
        return orderDetails
    }
}
