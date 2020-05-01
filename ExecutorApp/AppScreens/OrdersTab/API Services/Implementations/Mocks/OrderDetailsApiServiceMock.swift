//
//  OrderDetailsApiServiceMock.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrderDetailsApiServiceMock: OrderDetailsApiService {
    
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
