//
//  OrderDetails.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

enum OrderType {
    case promo
    case userText
    case executorText
}

struct OrderDetails {
    var id: Int
    var type: OrderType
    var cost: String
    var units: [OrderDetailUnit]
    var status: OrderStatus
    
    static func sample() -> OrderDetails {
        return OrderDetails(id: 1, type: .promo, cost: "2000", units: [OrderDetailUnit(title: "What to promote", data: "Dog toy"), OrderDetailUnit(title: "Link", data: "google.com"), OrderDetailUnit(title: "Text", data: "From executor"), OrderDetailUnit(title: "Options", data: "Post to Stories")], status: .todo)
    }
}
