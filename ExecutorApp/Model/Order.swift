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
    case rejectedModerator
    case uploading
    case moderation
}

struct Order {
    var imageURLString: String?
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
        return [Order(imageURLString: nil, id: 1, cost: "2000", orderTypeTitle: "Order description", date: "21.09.2019", status: .active), Order(id: 2, cost: "5000", orderTypeTitle: "Order description", date: "23.11.2019", status: .rejectedExecutor), Order(id: 3, cost: "3000", orderTypeTitle: "Some very very long order description", date: "23.12.2019", status: .done)]
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
        
        let imageURLString = dictionary["image"] as? String ?? ""
        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy, HH:mm"
        let dateString = dateFormatter.string(from: date)
        let sign = InfoService.shared.userInfo?.currencySign ?? ""
        let costString = sign == "₽" ? cost.string + " " + sign : sign + " " + cost.string
        let order = Order(imageURLString: imageURLString, id: id, cost: costString, orderTypeTitle: orderTypeTitle, date: dateString, status: orderStatus)
        return order
    }
    
    static func status(from string: String) -> OrderStatus? {
        switch string {
        case "moderation": return .moderation
        case "active" : return .active
        case "upload": return .uploading
        case "done": return .done
        case "rejected_executor": return .rejectedExecutor
        case "rejected_customer": return .rejectedCustomer
        case "rejected_moderator": return .rejectedModerator
        default: return nil
        }
    }
    
    static func statusString(status: OrderStatus) -> String {
        switch status {
        case .moderation: return Strings.statusModeration
        case .active: return Strings.statusActive
        case .uploading: return Strings.statusUploading
        case .done: return Strings.statusDone
        case .rejectedExecutor: return Strings.statusYouRejected
        case .rejectedCustomer: return Strings.statusYouRejected
        case .rejectedModerator: return Strings.statusRejectedModerator
        }
    }
}
