//
//  ForgotPassApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class ForgotPassApiService {
    
    func requestAuthCode(email: String, completion: @escaping (Bool, String?) -> Void) {
        var request = URLRequest(url: AppURL.resetPasswordURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["email" : email]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error as NSError? {
                    completion(false, error.localizedDescription)
                }
                if let data = data, let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    if let code = jsonDict["code"] as? String, code == "OK" {
                        completion(true, nil)
                    }
                    else {
                        if let message = jsonDict["message"] as? String {
                            completion(false, message)
                        }
                        else {
                            completion(false, nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func sendCodeAndPassword(code: String, email: String, password: String, confirmedPassword: String, completion: @escaping (_ token: String?, _ errorMessage: String?) -> Void) {
        var request = URLRequest(url: AppURL.resetPasswordURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["activationCode" : code, "email" : email, "password" : password, "passwordConfirmed": confirmedPassword]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error as NSError? {
                    completion(nil, error.localizedDescription)
                }
                else if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>,
                    let token = jsonDict["token"] as? String {
                    completion(token, nil)
                }
                else {
                    completion(nil, Strings.error)
                }
                
            }
            task.resume()
        }
    }
}



func executeAfterSecond(_ block: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: block)
}
