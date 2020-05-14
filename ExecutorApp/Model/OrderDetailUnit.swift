//
//  OrderDetailUnit.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderDetailUnit {
    var title: String
    var data: String
    
    static func samples() -> [OrderDetailUnit] {
        return [OrderDetailUnit(title: "What to promote", data: "Dog toy"), OrderDetailUnit(title: "Link", data: "google.com"), OrderDetailUnit(title: "Text", data: "From executor"), OrderDetailUnit(title: "Options", data: "Post to Stories")]
    }
}
