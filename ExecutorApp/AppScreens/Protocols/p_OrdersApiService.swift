//
//  p_OrdersApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

protocol OrdersApiService {
    func getOrders(completion: @escaping ([Order]?) -> Void)
}
