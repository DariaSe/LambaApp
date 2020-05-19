//
//  UserInfo.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct UserInfo {
    var socialMedia: [SocialMedia]
    var hashtags: [String]
    var orderSettings: [OrderSettings]
    var isReceivingOrders: Bool
    var currencySign: String
    
    static func sample() -> UserInfo {
        return UserInfo(socialMedia: [SocialMedia(id: 1, image: UIImage(named: "insta"), title: "Instagram", url: "harold_pain"), SocialMedia(id: 2, image: UIImage(named: "youtube"), title: "YouTube", url: "harold_pain"), SocialMedia(id: 3, image: UIImage(named: "tiktok"), title: "TikTok", url: "harold_pain")], hashtags: ["harold", "pain"], orderSettings: OrderSettings.sample(), isReceivingOrders: true, currencySign: "$")
    }
    
    static func initialize(from dictionary: Dictionary<String, Any>, completion: @escaping ((UserInfo?) -> Void)) {
        guard
            let isAccept = dictionary["isAccept"] as? Int,
            let isReceivingOrders = isAccept.bool,
            let socialLinks = dictionary["socialLinks"] as? [[String : Any]],
            let hashTags = dictionary["hashTags"] as? [String],
            let options = dictionary["options"] as? [[String : Any]],
            let currency = dictionary["currency"] as? [String : Any],
            let currencySign = currency["sign"] as? String
            else {
                completion(nil)
                return
        }
        let socialLinksArr = Array(socialLinks)
        let socialsDispatchGroup = DispatchGroup()
        var socialMediaArr = [SocialMedia]()
        socialsDispatchGroup.enter()
        for (index, socialLink) in socialLinksArr.enumerated() {
            SocialMedia.initialize(from: socialLink) { (socialMedia) in
                if let socialMedia = socialMedia {
                    socialMediaArr.append(socialMedia)
                }
                if index == socialLinks.count - 1 {
                    socialsDispatchGroup.leave()
                }
            }
        }
        let orderSettings = options
            .map { OrderSettings.initialize(from: $0) }
            .filter { $0 != nil } .map { $0! }
        
        socialsDispatchGroup.notify(queue: .main) {
            let userInfo = UserInfo(socialMedia: socialMediaArr, hashtags: hashTags, orderSettings: orderSettings, isReceivingOrders: isReceivingOrders, currencySign: currencySign)
            completion(userInfo)
        }
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
