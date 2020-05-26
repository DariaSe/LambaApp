//
//  UserInfo.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct UserInfo {
    var firstName: String
    var lastName: String
    var email: String
    var socialMedia: [SocialMedia]
    var hashtags: [String]
    var orderSettings: [OrderSettings]
    var isReceivingOrders: Bool
    var currencySign: String
    var role: UserRole?
    
    static func sample() -> UserInfo {
        return UserInfo(firstName: "Harold", lastName: "Pain", email: "email@email.com", socialMedia: [SocialMedia(id: 1, image: UIImage(named: "insta"), title: "Instagram", url: "harold_pain"), SocialMedia(id: 2, image: UIImage(named: "youtube"), title: "YouTube", url: "harold_pain"), SocialMedia(id: 3, image: UIImage(named: "tiktok"), title: "TikTok", url: "harold_pain")], hashtags: ["harold", "pain"], orderSettings: OrderSettings.sample(), isReceivingOrders: true, currencySign: "$", role: .executor)
    }
    
    static func initialize(from dictionary: [String : Any]) -> UserInfo? {
        guard
            let isAccept = dictionary["isAccept"] as? Int,
            let isReceivingOrders = isAccept.bool,
            let role = dictionary["role"] as? String
            else { return nil }
        let socialLinks = dictionary["socialLinks"] as? [[String : Any]] ?? [[:]]
        let socialMediaArr = socialLinks.map {SocialMedia.initialize(from: $0)} as? [SocialMedia] ?? []
        let options = dictionary["options"] as? [[String : Any]] ?? [[:]]
        let orderSettings = options
            .map { OrderSettings.initialize(from: $0) }
            .filter { $0 != nil } .map { $0! }
        let hashTags = dictionary["hashTags"] as? [String] ?? []
        let userRole = UserRole(rawValue: role)
        let currency = dictionary["currency"] as? [String : Any] ?? [:]
        let currencySign = currency["sign"] as? String ?? ""
        let firstName = dictionary["firstName"] as? String ?? ""
        let lastName = dictionary["lastName"] as? String ?? ""
        let email = dictionary["email"] as? String ?? ""
        
        
        return UserInfo(firstName: firstName, lastName: lastName, email: email, socialMedia: socialMediaArr, hashtags: hashTags, orderSettings: orderSettings, isReceivingOrders: isReceivingOrders, currencySign: currencySign, role: userRole)
    }
    
    
    func dict() -> [String : Any] {
        var dictionary = [String : Any]()
        dictionary["isAccept"] = self.isReceivingOrders ? 1 : 0
        dictionary["socialLinks"] = self.socialMedia.map { $0.dict() }
        dictionary["hashTags"] = hashtags
        dictionary["orderOptions"] = self.orderSettings.map { $0.dict() }
        
        #if DEBUG
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
        printWithTime(String(data: data, encoding: .utf8)!)
        #endif
        
        return dictionary
    }
}

extension UserInfo: Equatable {
    static func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
        return
            lhs.hashtags == rhs.hashtags &&
                lhs.socialMedia == rhs.socialMedia &&
                lhs.orderSettings == rhs.orderSettings &&
                lhs.isReceivingOrders == rhs.isReceivingOrders
    }
}

enum UserRole: String {
    case customer
    case executor
}
