//
//  OrdersApiServiceMock.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrdersApiServiceMock: OrdersApiService {
    
    var isMore: Bool = false
    
    var page: Int = 1
    var limit: Int = 10
    
    func getOrders(completion: @escaping ([Order]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isMore = true
            completion(Order.sampleOrders())
        }
    }
    
    func showOrderDetails(orderID: Int, completion: @escaping (OrderDetails?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(OrderDetails.sample())
        }
    }
    
    
    
}
