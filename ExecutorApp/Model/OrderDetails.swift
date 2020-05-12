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
    var orderTypeTitle: String
    var cost: String
    var units: [OrderDetailUnit]
    var status: OrderStatus
    
    static func sample() -> OrderDetails {
        return OrderDetails(id: 1, type: .promo, orderTypeTitle: "Promo", cost: "2000", units: [OrderDetailUnit(title: "What to promote", data: "Dog toy"), OrderDetailUnit(title: "Link", data: "google.com"), OrderDetailUnit(title: "Text", data: "From executor"), OrderDetailUnit(title: "Options", data: "Post to Stories")], status: .active)
    }
    
    static func initialize(from dictionary: [String : Any]) -> OrderDetails? {
        guard
            let id = dictionary["id"] as? Int,
            let orderTypeDict = dictionary["orderType"] as? [String : Any],
            let orderTypeInt = orderTypeDict["id"] as? Int,
            let orderType = OrderType(rawValue: orderTypeInt),
            let orderTypeTitle = orderTypeDict["title"] as? String,
            let statusString = dictionary["status"] as? String,
            let orderStatus = Order.status(from: statusString),
            let cost = dictionary["costs"] as? Int else { return nil }

        let orderDetails = OrderDetails(id: id, type: orderType, orderTypeTitle: orderTypeTitle, cost: String(cost), units: [], status: orderStatus)
        return orderDetails
    }
}
