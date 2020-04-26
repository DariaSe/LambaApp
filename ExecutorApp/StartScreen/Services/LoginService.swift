//
//  LoginService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class LoginService {
    
    static let baseURL = "https://lamba.media"
    
    static let api = "/api/"
    
    static func login(email: String, password: String, completion: @escaping (_ success: Bool, _ token: String?, _ error: String?) -> Void) {
        let url = URL(string: baseURL + api + "login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let json = ["email" : email, "password": password]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error as NSError? {
                    completion(false, nil, error.localizedDescription)
                }
                else if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>,
                    let token = jsonDict["token"] as? String {
                    completion(true, token, nil)
                }
                else {
                    completion(false, nil, Strings.incorrectEmailOrPassword)
                }
                
            }
            task.resume()
        }
    }
}
