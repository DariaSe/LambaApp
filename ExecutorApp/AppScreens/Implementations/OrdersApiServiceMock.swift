//
//  OrdersApiServiceMock.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrdersApiServiceDataMock: OrdersApiService {
    func getOrders(completion: @escaping ([Order]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(Order.sampleOrders())
        }
    }
}

class OrdersApiServiceEmptyMock: OrdersApiService {
    func getOrders(completion: @escaping ([Order]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion([])
        }
    }
}

class OrdersApiServiceErrorMock: OrdersApiService {
    func getOrders(completion: @escaping ([Order]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(nil)
        }
    }
}
