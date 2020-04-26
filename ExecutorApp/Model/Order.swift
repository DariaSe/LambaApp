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
    case rejected = "Rejected"
    case uploading = "Uploading"
}

struct Order {
    var id: Int
    var cost: String
    var description: String
    var date: String
    var status: OrderStatus
    
    func withStatus(_ status: OrderStatus) -> Order {
        var order = self
        order.status = status
        return self
    }
    
    static func sampleOrders() -> [Order] {
        return [Order(id: 1, cost: "2000", description: "Order description", date: "21.09.2019", status: .todo), Order(id: 2, cost: "5000", description: "Order description", date: "23.11.2019", status: .rejected), Order(id: 3, cost: "3000", description: "Some very very long order description", date: "23.12.2019", status: .done)]
    }
    
}
