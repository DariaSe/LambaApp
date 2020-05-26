//
//  Order.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

enum OrderStatus {
    case done
    case active
    case rejectedExecutor
    case rejectedCustomer
    case uploading
}

struct Order {
    var image: UIImage?
    var id: Int
    var cost: String
    var orderTypeTitle: String
    var date: String
    var status: OrderStatus
    
    func withStatus(_ status: OrderStatus) -> Order {
        var order = self
        order.status = status
        return self
    }
    
    static func sampleOrders() -> [Order] {
        return [Order(image: UIImage(named: "DollarSign"), id: 1, cost: "2000", orderTypeTitle: "Order description", date: "21.09.2019", status: .active), Order(id: 2, cost: "5000", orderTypeTitle: "Order description", date: "23.11.2019", status: .rejectedExecutor), Order(id: 3, cost: "3000", orderTypeTitle: "Some very very long order description", date: "23.12.2019", status: .done)]
    }
    
    static func initialize(from dictionary: [String : Any]) -> Order? {
        guard
            let id = dictionary["id"] as? Int,
            let cost = dictionary["costs"] as? Int,
            let orderTypeDict = dictionary["orderType"] as? [String : Any],
            let orderTypeTitle = orderTypeDict["title"] as? String,
            let timeInterval = dictionary["createdAt"] as? TimeInterval,
            let statusString = dictionary["status"] as? String,
            let orderStatus = status(from: statusString) else { return nil }
        
        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy, HH:mm"
        let dateString = dateFormatter.string(from: date)
        let sign = InfoService.shared.userInfo?.currencySign ?? ""
        let costString = sign == "₽" ? cost.string + " " + sign : sign + " " + cost.string
        let order = Order(id: id, cost: costString, orderTypeTitle: orderTypeTitle, date: dateString, status: orderStatus)
        return order
    }
    
    static func status(from string: String) -> OrderStatus? {
        switch string {
        case "active" : return .active
        case "rejected_executor": return .rejectedExecutor
        case "rejected_customer": return .rejectedCustomer
        case "done": return .done
        case "upload": return .uploading
        default: return nil
        }
    }
    
    static func statusString(status: OrderStatus) -> String {
        switch status {
        case .active: return Strings.statusActive
        case .done: return Strings.statusDone
        case .rejectedExecutor: return Strings.statusYouRejected
        case .rejectedCustomer: return Strings.statusYouRejected
        case .uploading: return Strings.statusUploading
        }
    }
}
