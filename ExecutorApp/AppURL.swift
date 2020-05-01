//
//  URLComponents.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 30.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct AppURL {
    static let baseURL = "https://lamba.media"
    
    static let xAuthToken = "x-auth-token"
    
    // API
    static let api = "/api"
    
    static let login = "/login"
    static let info = "/info"
       
    static let loginURL = URL(string: baseURL + api + login)!
    static let checkInfoURL = URL(string: baseURL + api + info)!
    
    // Executor controller
    static let executor = "/executor"
    
    static let orders = "/orders"
    static let order = "/order"
    static let orderReject = "/order-reject"
    
    static let getOrdersURL = URL(string: baseURL + api + executor + orders)!
    static func getOrderDetailsURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + order + "/" + String(orderID))!
    }
    static func rejectOrderURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + orderReject + "/" + String(orderID))!
    }
}
