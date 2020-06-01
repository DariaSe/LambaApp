//
//  CustomerOrdersApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class CustomerOrdersApiService {
    
    var delegate: (URLSessionDataDelegate&URLSessionDownloadDelegate)?
    
    var isMore: Bool = false
    
    var page: Int = 1
    var limit: Int = 30
    
    var orderID: Int?
    
    lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: orderID?.string ?? "download")
        return URLSession(configuration: configuration,
                          delegate: delegate,
                          delegateQueue: nil) }()
    
    
    func getOrders(completion: @escaping ([Order]?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getCustomerOrdersURL(page: page, limit: limit)) else { return }
        let task = URLSession.shared.dataTask(with: request) { [unowned self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                else if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let ordersDict = jsonDict["orders"] as? Array<[String : Any]> {
                    let orders = ordersDict
                        .map { Order.initialize(from: $0) }
                        .filter { $0 != nil }
                    self.isMore = orders.count == self.limit
                    completion(orders as? [Order], nil)
                }
                else {
                    completion(nil, Strings.error)
                }
            }
        }
        task.resume()
    }
    
    func getOrderDetails(orderID: Int, completion: @escaping (OrderDetails?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getCustomerOrderDetailsURL(orderID: orderID)) else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let order = jsonDict["order"] as? [String : Any] {
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
    
    func downloadVideo(url: URL) {
        let task = downloadSession.downloadTask(with: url)
        task.resume()
    }
    
    func cancelOrder(orderID: Int, completion: @escaping(Bool, String?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.customerCancelOrderURL(orderID: orderID))
        request.httpMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        if let locale = Locale.current.languageCode {
            request.setValue(locale, forHTTPHeaderField: AppURL.locale)
        }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func openDispute(orderID: Int) {
        
    }
}
