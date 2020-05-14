//
//  e_URLRequest.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 08.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func signedGetRequest(url: URL) -> URLRequest? {
        guard let token = Defaults.token else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        if let locale = Locale.current.languageCode {
            request.setValue(locale, forHTTPHeaderField: AppURL.locale)
        }
        return request
    }
    
    static func signedPostRequest(url: URL, jsonDict: ([String : Any])?) -> URLRequest? {
        guard let token = Defaults.token else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        if let locale = Locale.current.languageCode {
            request.setValue(locale, forHTTPHeaderField: AppURL.locale)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let jsonDict = jsonDict {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else { return nil }
            request.httpBody = jsonData
        }
        return request
    }
}
