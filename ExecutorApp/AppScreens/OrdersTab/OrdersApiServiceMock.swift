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
    
    func getOrders(completion: @escaping ([Order]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isMore = true
            completion(Order.sampleOrders())
        }
    }
    
    func loadMore(completion: @escaping ([Order]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isMore = false
            completion(Order.sampleOrders())
        }
    }
    
    func showOrderDetails(orderID: Int, completion: @escaping (OrderDetails?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(OrderDetails.sample())
        }
    }
    
    func rejectOrder(orderID: Int, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
    
    func uploadVideo(orderID: Int, url: URL, completion: @escaping (Int, Bool) -> Void) {
         if let data = try? Data(contentsOf: url) {
             print(data)
         }
    }
    
}
