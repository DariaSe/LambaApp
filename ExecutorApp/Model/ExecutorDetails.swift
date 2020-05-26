//
//  ExecutorDetails.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct ExecutorDetails {
    var id: Int
    var image: UIImage?
    var isFavorite: Bool
    var socialMedia: [SocialMedia]
    var orderSettings: [OrderSettings]
    var isReceivingOrders: Bool
}
