//
//  Executor.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct Executor {
    var id: Int
    var imageURLString: String
    var name: String
    var hashtags: String
    var isFavorite: Bool
    
    func favoriteChanged() -> Executor {
        var executor = self
        executor.isFavorite = !executor.isFavorite
        return executor
    }
    
    static func sample() -> [Executor] {
        let ex1 = Executor(id: 1, imageURLString: "", name: "Harold", hashtags: "harold pain", isFavorite: true)
        let ex2 = Executor(id: 2, imageURLString: "", name: "Harold Harold", hashtags: "harold pain more pain", isFavorite: false)
        return [ex1, ex2, ex1, ex2]
    }
    
    static func initialize(from dictionary: [String : Any]) -> Executor? {
        guard
            let id = dictionary["id"] as? Int,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let hashtagsArray = dictionary["hashTags"] as? [String],
            let isFavoriteInt = dictionary["isFavorite"] as? Int,
            let isFavorite = isFavoriteInt.bool else { return nil }
        let hashtags = hashtagsArray.joined(separator: " ")
        let imageURLString = dictionary["image"] as? String ?? ""
        return Executor(id: id, imageURLString: imageURLString, name: [firstName, lastName].joined(separator: " "), hashtags: hashtags, isFavorite: isFavorite)
    }
}

