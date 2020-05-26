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
    var image: UIImage?
    var title: String
    var url: String
    
    static func initialize(from dictionary: [String : Any]) -> SocialMedia? {
        guard
            let socialType = dictionary["socialType"] as? [String : Any],
            let id = socialType["id"] as? Int,
            let title = socialType["title"] as? String,
            let url = dictionary["url"] as? String
            else { return nil }
            return SocialMedia(id: id, image: nil, title: title, url: url)
    }
    
    func dict() -> [String : Any] {
        var dict = [String : Any]()
        let socialType = ["id" : self.id]
        dict["socialType"] = socialType
        dict["url"] = self.url
        return dict
    }
}
