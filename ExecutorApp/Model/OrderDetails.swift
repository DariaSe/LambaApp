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
    var videoURL: URL?
    
    static func sample() -> OrderDetails {
        return OrderDetails(id: 1, type: .promo, orderTypeTitle: "Promo", cost: "2000", units: OrderDetailUnit.samples(), status: .active, videoURL: nil)
    }
    
    static func initialize(from dictionary: [String : Any]) -> OrderDetails? {
        guard
            let id = dictionary["id"] as? Int,
            let orderTypeDict = dictionary["orderType"] as? [String : Any],
            let orderTypeInt = orderTypeDict["id"] as? Int,
            let orderType = OrderType(rawValue: orderTypeInt),
            let orderTypeTitle = orderTypeDict["title"] as? String,
            let fields = dictionary["fields"] as? [[String : Any]],
            let statusString = dictionary["status"] as? String,
            let orderStatus = Order.status(from: statusString),
            let cost = dictionary["costs"] as? Int,
            let videoURLString = dictionary["videoUrl"] as? String
            else { return nil }
        let sign = InfoService.shared.userInfo?.currencySign ?? ""
        let costString = sign == "₽" ? cost.string + " " + sign : sign + " " + cost.string
        let videoURL = URL(string: videoURLString)
        let units = fields.map{ OrderDetailUnit.initialize(from: $0) }.filter { $0 != nil } as! [OrderDetailUnit]
        let sortedUnits = units.sorted(by: <)
        let orderDetails = OrderDetails(id: id, type: orderType, orderTypeTitle: orderTypeTitle, cost: costString, units: sortedUnits, status: orderStatus, videoURL: videoURL)
        return orderDetails
    }
}
