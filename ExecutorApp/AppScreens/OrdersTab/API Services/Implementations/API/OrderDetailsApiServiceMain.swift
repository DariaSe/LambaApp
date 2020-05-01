//
//  OrderDetailsApiServiceMain.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrderDetailsApiServiceMain: OrderDetailsApiService {
    
    func rejectOrder(orderID: Int, completion: @escaping (Bool) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.rejectOrderURL(orderID: orderID))
        request.httpMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
            if let data = data, let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                completion(true)
            }
        }
        task.resume()
    }
    
    func uploadVideo(orderID: Int, url: URL, completion: @escaping (Int, Bool) -> Void) {
        
    }
    
}
