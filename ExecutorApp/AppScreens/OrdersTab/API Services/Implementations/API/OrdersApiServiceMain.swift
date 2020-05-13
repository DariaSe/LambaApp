//
//  OrdersApiServiceMain.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrdersApiServiceMain {
    
    var isMore: Bool = false
    
    var page: Int = 1
    var limit: Int = 30
    
    func getOrders(completion: @escaping ([Order]?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getOrdersURL(page: page, limit: limit)) else { return }
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let ordersDict = jsonDict["orders"] as? [[String : Any]] {
                    let orders = ordersDict
                        .map { Order.initialize(from: $0) }
                        .filter { $0 != nil }
                    self?.isMore = orders.count == self?.limit
                    completion(orders as? [Order], nil)
                }
                else {
                    completion(nil, Strings.error)
                }
            }
        }
        task.resume()
    }
    
    func showOrderDetails(orderID: Int, completion: @escaping (OrderDetails?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getOrderDetailsURL(orderID: orderID)) else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let order = jsonDict["order"] as? [String : Any] {
                    print(order)
                    let orderDetails = OrderDetails.initialize(from: order)
                    completion(orderDetails, nil)
                }
                else {
                    completion(nil, Strings.error)
                }
                
            }
        }
        task.resume()
    }
}
