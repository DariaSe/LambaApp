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
        return UserInfo(image: UIImage(named: "Harold"), socialMedia: [SocialMedia(image: UIImage(named: "insta"), title: "Instagram", baseURL: "", nickName: "@harold_pain"), SocialMedia(image: UIImage(named: "youtube"), title: "YouTube", baseURL: "", nickName: "@harold_pain"), SocialMedia(image: UIImage(named: "tiktok"), title: "TikTok", baseURL: "", nickName: "@harold_pain")], hashtags: ["harold", "pain"], orderSettings: OrderSettings.sample(), isReceivingOrders: true)
    }
    
    static func initialize(from dictionary: Dictionary<String, Any>, completion: @escaping (UserInfo?) -> Void) {
        var userImage: UIImage?
        if let imageURLString = dictionary["image"] as? String,
            let imageURL = URL(string: imageURLString) {
            getImage(from: imageURL) { (image) in
                userImage = image
            }
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
