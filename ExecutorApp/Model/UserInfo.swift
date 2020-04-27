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
        return UserInfo(image: UIImage(named: "Harold"), socialMedia: [SocialMedia(image: UIImage(named: "insta"), title: "Instagram", baseURL: "", nickName: "@harold_pain"), SocialMedia(image: UIImage(named: "youtube"), title: "YouTube", baseURL: "", nickName: "@harold_pain"), SocialMedia(image: UIImage(named: "tiktok"), title: "TikTok", baseURL: "", nickName: "@harold_pain")], hashtags: ["harold", "pain"], orderSettings: [OrderSettings(title: "Post to stories", price: "2000", isOn: true)], isReceivingOrders: true)
    }
}
