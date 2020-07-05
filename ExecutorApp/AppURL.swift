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
    static let signUp = "/signup"
    static let resetPassword = "/reset-password"
    
    static let loginURL = URL(string: baseURL + api + login)!
    static let checkInfoURL = URL(string: baseURL + api + info)!
    static let logoutURL = URL(string: baseURL + api + logout)!
    static let signUpURL = URL(string: baseURL + api + signUp)!
    static let resetPasswordURL = URL(string: baseURL + api + resetPassword)!
    
    // Common
    static let orders = "/orders"
    static let order = "/order"
    
    static let image = "/image"
    static let passwordChange = "/password-change"
    static let settings = "/settings"
    
    // Customer
    static let customer = "/customer"
    
    static let executors = "/executors"
    static let favorite = "/favorite"
    static let dispute = "/dispute"
    static let changeEmail = "/change-email"
    
    // Customer URLs
    
    static func getExecutorsURL(page: Int, limit: Int, search: String, order: String, direction: String) -> URL {
        let searchEncoded = search.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let query = "?page=\(page)&limit=\(limit)&search=\(searchEncoded)&order=\(order)&direction=\(direction)"
        return URL(string: baseURL + api + customer + executors + query)!
    }
    static func getExecutorDetailsURL(executorID: Int) -> URL {
        return URL(string: baseURL + api + customer + executor + "/" + executorID.string)!
    }
    static func setFavorite(executorID: Int) -> URL {
        return URL(string: baseURL + api + customer + favorite + "/" + String(executorID))!
    }
    static let createOrder = URL(string: baseURL + api + customer + order)!
    static func getCustomerOrdersURL(page: Int, limit: Int) -> URL {
        let query = "?page=\(page)&limit=\(limit)"
        return URL(string: baseURL + api + customer + orders + query)!
    }
    static func getCustomerOrderDetailsURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + customer + order + "/" + String(orderID))!
    }
    static func customerCancelOrderURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + customer + order + "/" + String(orderID))!
    }
    static func openDisputeURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + customer + order + "/" + String(orderID) + dispute)!
    }
    static let customerImageChangeURL = URL(string: baseURL + api + customer + image)!
    static let customerPasswordChangeURL = URL(string: baseURL + api + customer + passwordChange)!
    static let customerChangeSettingsURL = URL(string: baseURL + api + customer + settings)!
    static let customerChangeEmailURL = URL(string: baseURL + api + customer + changeEmail)!
    
    
    // Executor
    static let executor = "/executor"
    
    static let changeOrderStatus = "/order-status"
    static let videoUpload = "/upload"
    static let orderReject = "/order-reject"
    
    static let finances = "/finances"
    static let transferDescription = "/finances-description"
    #warning("replace with actual api")
    static let transfer = "/transfer"
    
    // Executor URLs
    static func getExecutorOrdersURL(page: Int, limit: Int) -> URL {
        let query = "?page=\(page)&limit=\(limit)"
        return URL(string: baseURL + api + executor + orders + query)!
    }
    static func getExecutorOrderDetailsURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + order + "/" + String(orderID))!
    }
    static func setOrderStatusURL() -> URL {
        return URL(string: baseURL + api + executor + changeOrderStatus)!
    }
    static func uploadVideoURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + videoUpload + "/" + String(orderID))!
    }
    static func executorRejectOrderURL(orderID: Int) -> URL {
        return URL(string: baseURL + api + executor + orderReject + "/" + String(orderID))!
    }
    
    static let financesURL = URL(string: baseURL + api + executor + finances)!
    static let transferDescriptionURL = URL(string: baseURL + api + executor + transferDescription)!
    static let transferURL = URL(string: baseURL + api + executor + transfer)!
    
    static let executorImageChangeURL = URL(string: baseURL + api + executor + image)!
    static let executorPasswordChangeURL = URL(string: baseURL + api + executor + passwordChange)!
    static let executorChangeSettingsURL = URL(string: baseURL + api + executor + settings)!
}
