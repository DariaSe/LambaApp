//
//  Order.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

enum OrderStatus: String {
    case done = "Done"
    case todo = "To Do"
    case cancelled = "Cancelled"
}

struct Order {
    var cost: String
    var description: String
    var date: String
    var status: OrderStatus
    
    static func sampleOrders() -> [Order] {
        return [Order(cost: "2000", description: "Order description", date: "21.09.2019", status: .todo), Order(cost: "5000", description: "Order description", date: "23.11.2019", status: .cancelled), Order(cost: "3000", description: "Some very very long order description", date: "23.12.2019", status: .done)]
    }
    
}
