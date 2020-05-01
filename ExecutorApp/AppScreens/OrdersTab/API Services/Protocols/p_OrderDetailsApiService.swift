//
//  OrderDetailsApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

protocol OrderDetailsApiService {
    
    func rejectOrder(orderID: Int, completion: @escaping (Bool) -> Void)
    
    func uploadVideo(orderID: Int, url: URL, completion: @escaping(_ orderID: Int, _ success: Bool) -> Void)
}
