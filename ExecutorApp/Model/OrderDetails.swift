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
    var thumbnailURL: URL?
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
            let statusString = dictionary["status"] as? String,
            let orderStatus = Order.status(from: statusString),
            let cost = dictionary["costs"] as? Int
            else { return nil }
        var currencySign: String
        if let executor = dictionary["executorDto"] as? [String : Any], let currency = executor["currency"] as? [String : Any], let sign = currency["sign"] as? String {
            currencySign = sign
        }
        else {
            currencySign = InfoService.shared.userInfo?.currencySign ?? ""
        }
        let costString = currencySign == "₽" ? cost.string + " " + currencySign : currencySign + " " + cost.string
        
        let thumbnailURLString = dictionary["videoPreview"] as? String ?? ""
        let thumbnailURL = URL(string: thumbnailURLString)
        let videoURLString = dictionary["videoUrl"] as? String ?? ""
        let videoURL = URL(string: videoURLString)
        
        let fields = dictionary["fields"] as? [[String : Any]] ?? [[:]]
        let units = fields.compactMap(OrderDetailUnit.initialize)
        let sortedUnits = units.sorted(by: <)
        let orderDetails = OrderDetails(id: id, type: orderType, orderTypeTitle: orderTypeTitle, cost: costString, units: sortedUnits, status: orderStatus, thumbnailURL: thumbnailURL, videoURL: videoURL)
        return orderDetails
    }
}
