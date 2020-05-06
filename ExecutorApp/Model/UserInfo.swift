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
    
    static func sample() -> UserInfo {
        return UserInfo(image: UIImage(named: "Harold"), socialMedia: [SocialMedia(id: 1, image: UIImage(named: "insta"), title: "Instagram", url: "harold_pain"), SocialMedia(id: 2, image: UIImage(named: "youtube"), title: "YouTube", url: "harold_pain"), SocialMedia(id: 3, image: UIImage(named: "tiktok"), title: "TikTok", url: "harold_pain")], hashtags: ["harold", "pain"], orderSettings: OrderSettings.sample(), isReceivingOrders: true)
    }
    
    static func initialize(from dictionary: Dictionary<String, Any>, completion: @escaping ((UserInfo?) -> Void)) {
        guard
            let socialLinks = dictionary["socialLinks"] as? [[String : Any]],
            let hashTags = dictionary["hashTags"] as? [String],
            let options = dictionary["options"] as? [[String : Any]]
            else {
                completion(nil)
                return
        }
        #warning("get isReceivingOrders boolean")
        let socialMedia = socialLinks
            .map { SocialMedia.initialize(from: $0) }
            .filter { $0 != nil } .map { $0! }
        let orderSettings = options
            .map { OrderSettings.initialize(from: $0) }
            .filter { $0 != nil } .map { $0! }
        
        if let imageURLString = dictionary["image"] as? String,
            let imageURL = URL(string: imageURLString) {
            getImage(from: imageURL) { (image) in
                let userInfo = UserInfo(image: image, socialMedia: socialMedia, hashtags: hashTags, orderSettings: orderSettings, isReceivingOrders: true)
                completion(userInfo)
            }
        }
        else {
            let userInfo = UserInfo(image: nil, socialMedia: socialMedia, hashtags: hashTags, orderSettings: orderSettings, isReceivingOrders: true)
            completion(userInfo)
        }
    }
    
    static func getImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            if let data = data {
                completion(UIImage(data: data))
            }
            else {
                completion(nil)
            }
        })
        dataTask.resume()
    }
}
