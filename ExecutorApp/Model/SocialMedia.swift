//
//  SocialMedia.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct SocialMedia: Equatable {
    var id: Int
    var imageURLString: String
    var title: String
    var url: String
    
    static func samples() -> [SocialMedia] {
        return [SocialMedia(id: 1, imageURLString: "", title: "Instagram", url: "harold_pain"), SocialMedia(id: 2, imageURLString: "", title: "YouTube", url: "harold_pain"), SocialMedia(id: 3, imageURLString: "", title: "TikTok", url: "harold_pain")]
    }
    
    static func initialize(from dictionary: [String : Any]) -> SocialMedia? {
        guard
            let socialType = dictionary["socialType"] as? [String : Any],
            let id = socialType["id"] as? Int,
            let title = socialType["title"] as? String,
            let url = dictionary["url"] as? String
            else { return nil }
        let imageURLString = socialType["image"] as? String ?? ""
        return SocialMedia(id: id, imageURLString: imageURLString, title: title, url: url)
    }
    
    func dict() -> [String : Any] {
        var dict = [String : Any]()
        let socialType = ["id" : self.id]
        dict["socialType"] = socialType
        dict["url"] = self.url
        return dict
    }
}
