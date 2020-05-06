//
//  p_OrdersApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

protocol OrdersApiService {
    var isMore: Bool { get set }
    
    func getOrders(completion: @escaping ([Order]?) -> Void)
    func loadMore(completion: @escaping ([Order]?) -> Void)
    
    func showOrderDetails(orderID: Int, completion: @escaping (OrderDetails?) -> Void)
    
}