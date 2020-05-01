//
//  OrderSettings.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct OrderSettings {
    var title: String
    var price: String
    var isOn: Bool
    var currency: String
    
    static func sample() -> [OrderSettings] {
        return [OrderSettings(title: "Can post to stories", price: "2000", isOn: true, currency: "₽"), OrderSettings(title: "Can post to feed", price: "4000", isOn: true, currency: "₽"), OrderSettings(title: "Can make videocall", price: "8000", isOn: false, currency: "₽"), OrderSettings(title: "My text", price: "15000", isOn: true, currency: "₽")]
    }
    
    
}
