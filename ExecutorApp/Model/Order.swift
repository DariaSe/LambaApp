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
    case active = "Active"
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
        return [Order(id: 1, cost: "2000", description: "Order description", date: "21.09.2019", status: .active), Order(id: 2, cost: "5000", description: "Order description", date: "23.11.2019", status: .rejected), Order(id: 3, cost: "3000", description: "Some very very long order description", date: "23.12.2019", status: .done)]
    }
    
    static func initialize(from dictionary: [String : Any]) -> Order? {
        guard
            let id = dictionary["id"] as? Int,
            let cost = dictionary["costs"] as? Int,
            let description = dictionary["description"] as? String,
            let timeInterval = dictionary["createdAt"] as? TimeInterval,
            let statusString = dictionary["status"] as? String,
            let orderStatus = status(from: statusString) else { return nil }
             
        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy, HH:mm"
        let dateString = dateFormatter.string(from: date)
        let order = Order(id: id, cost: String(cost), description: description, date: dateString, status: orderStatus)
        return order
    }
    
    static func status(from string: String) -> OrderStatus? {
        switch string {
        case "active" : return .active
        case "rejected_executor": return .rejected
        case "done": return .done
        default: return nil
        }
    }
}
