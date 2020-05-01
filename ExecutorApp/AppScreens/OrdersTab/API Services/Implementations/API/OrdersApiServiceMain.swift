//
//  OrdersApiServiceMain.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrdersApiServiceMain: OrdersApiService {
    
    var isMore: Bool = true
    
    func getOrders(completion: @escaping ([Order]?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.getOrdersURL)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            if let data = data,
                let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let ordersDict = jsonDict["orders"] as? [[String : Any]] {
                let orders = ordersDict
                    .map { Order.initialize(from: $0) }
                    .filter { $0 != nil }
                completion(orders as? [Order])
            }
        }
        task.resume()
    }
    
    func loadMore(completion: @escaping ([Order]?) -> Void) {
        guard let token = Defaults.token else { return }
        
    }
    
    func showOrderDetails(orderID: Int, completion: @escaping (OrderDetails?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.getOrderDetailsURL(orderID: orderID))
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            if let data = data,
                let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let order = jsonDict["order"] as? [String : Any] {
                let orderDetails = OrderDetails.initialize(from: order)
                completion(orderDetails)
            }
        }
        task.resume()
    }
    
}
