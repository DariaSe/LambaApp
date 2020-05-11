//
//  UserInfo.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct UserInfo {
    var image: UIImage?
    var socialMedia: [SocialMedia]
    var hashtags: [String]
    var orderSettings: [OrderSettings]
    var isReceivingOrders: Bool
    var currencySign: String
    
    static func sample() -> UserInfo {
        return UserInfo(image: UIImage(named: "Harold"), socialMedia: [SocialMedia(id: 1, image: UIImage(named: "insta"), title: "Instagram", url: "harold_pain"), SocialMedia(id: 2, image: UIImage(named: "youtube"), title: "YouTube", url: "harold_pain"), SocialMedia(id: 3, image: UIImage(named: "tiktok"), title: "TikTok", url: "harold_pain")], hashtags: ["harold", "pain"], orderSettings: OrderSettings.sample(), isReceivingOrders: true, currencySign: "$")
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
            if let imageURLString = dictionary["image"] as? String,
                let imageURL = URL(string: imageURLString) {
                UIImage.getImage(from: imageURL) { (image) in
                    let userInfo = UserInfo(image: image, socialMedia: socialMediaArr, hashtags: hashTags, orderSettings: orderSettings, isReceivingOrders: isReceivingOrders, currencySign: currencySign)
                    completion(userInfo)
                }
            }
            else {
                let userInfo = UserInfo(image: nil, socialMedia: socialMediaArr, hashtags: hashTags, orderSettings: orderSettings, isReceivingOrders: true, currencySign: currencySign)
                completion(userInfo)
            }
        }
    }
    
    
    func dict() -> [String : Any] {
        var dictionary = [String : Any]()
        dictionary["isAccept"] = self.isReceivingOrders ? 1 : 0
        dictionary["socialLinks"] = self.socialMedia.map { $0.dict() }
        dictionary["hashTags"] = hashtags
        dictionary["orderOptions"] = self.orderSettings.map { $0.dict() }
        return dictionary
    }
}
