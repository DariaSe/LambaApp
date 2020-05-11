//
//  SocialMedia.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct SocialMedia {
    var id: Int
    var image: UIImage?
    var title: String
    var url: String
    
    static func initialize(from dictionary: Dictionary<String, Any>, completion: @escaping (SocialMedia?) -> Void) {
        guard
            let socialType = dictionary["socialType"] as? [String : Any],
            let id = socialType["id"] as? Int,
            let title = socialType["title"] as? String,
            let url = dictionary["url"] as? String,
            let imageURLString = socialType["image"] as? String,
            let imageURL = URL(string: imageURLString)
            else { completion(nil); return }
        UIImage.getImage(from: imageURL) { (image) in
            let socialMedia = SocialMedia(id: id, image: image, title: title, url: url)
            completion(socialMedia)
        }
    }
    
    func dict() -> [String : Any] {
        var dict = [String : Any]()
        let socialType = ["id" : self.id]
        dict["socialType"] = socialType
        dict["url"] = self.url
        return dict
    }
}
