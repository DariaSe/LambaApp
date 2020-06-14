//
//  ExecutorDetails.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct ExecutorDetails {
    var id: Int
    var firstName: String
    var lastName: String
    var imageURLString: String
    var isFavorite: Bool
    var socialMedia: [SocialMedia]
    var orderSettings: [OrderSettings]
    var isReceivingOrders: Bool
    
    static func sample() -> ExecutorDetails {
        return ExecutorDetails(id: 1, firstName: "Harold", lastName: "Pain", imageURLString: "", isFavorite: true, socialMedia: SocialMedia.samples(), orderSettings: OrderSettings.sample(), isReceivingOrders: true)
    }
    
    static func initialize(from dictionary: [String : Any]) -> ExecutorDetails? {
        guard
            let id = dictionary["id"] as? Int,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let isFavoriteInt = dictionary["isFavorite"] as? Int,
            let isFavorite = isFavoriteInt.bool,
            let isReceivingOrdersInt = dictionary["isAccept"] as? Int,
            let isReceivingOrders = isReceivingOrdersInt.bool
            else { return nil }
        let imageURLString = dictionary["image"] as? String ?? ""
        let socialMediaDict = dictionary["socialLinks"] as? [[String : Any]] ?? [[:]]
        let socials = socialMediaDict.compactMap(SocialMedia.initialize)
        let optionsDict = dictionary["options"] as? [[String : Any]] ?? [[:]]
        let orderSettings = optionsDict.compactMap(OrderSettings.initialize)
        return ExecutorDetails(id: id, firstName: firstName, lastName: lastName, imageURLString: imageURLString, isFavorite: isFavorite, socialMedia: socials, orderSettings: orderSettings, isReceivingOrders: isReceivingOrders)
    }
}
