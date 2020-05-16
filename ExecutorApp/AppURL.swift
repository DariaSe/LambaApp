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
    static let locale = "locale"
    
    // API
    static let api = "/api"
    
    static let login = "/login"
    static let info = "/info"
    static let logout = "/logout"
       
    static let loginURL = URL(string: baseURL + api + login)!
    static let checkInfoURL = URL(string: baseURL + api + info)!
    static let logoutURL = URL(string: baseURL + api + logout)!
    
    // Executor controller
    static let executor = "/executor"
    
    static let orders = "/orders"
    static let order = "/order"
    
    static let changeOrderStatus = "/order-status"
    static let videoUpload = "/upload"
    static let orderReject = "/order-reject"
    
    static let finances = "/finances"
    static let transferDescription = "/finances-description"
     #warning("replace with actual api")
    static let transfer = "/transfer"
    
    static let image = "/image"
    static let passwordChange = "/password-change"
    static let settings = "/settings"
    
    static func getOrdersURL(page: Int, limit: Int) -> URL {
        let query = "?page=\(page)&limit=\(limit)"
        return URL(string: baseURL + api + executor + orders + query)!
    }
    static func getOrderDetailsURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + order + "/" + String(orderID))!
    }
    static func setOrderStatusURL() -> URL {
        return URL(string: baseURL + api + executor + changeOrderStatus)!
    }
    static func uploadVideoURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + videoUpload + "/" + String(orderID))!
    }
    static func rejectOrderURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + orderReject + "/" + String(orderID))!
    }
    
    static let financesURL = URL(string: baseURL + api + executor + finances)!
    static let transferDescriptionURL = URL(string: baseURL + api + executor + transferDescription)!
    static let transferURL = URL(string: baseURL + api + executor + transfer)!
    
    static let imageChangeURL = URL(string: baseURL + api + executor + image)!
    static let passwordChangeURL = URL(string: baseURL + api + executor + passwordChange)!
    static let changeSettingsURL = URL(string: baseURL + api + executor + settings)!
}
