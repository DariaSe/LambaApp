//
//  RegistrationApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class RegistrationApiService {
    
    func register(email: String, password: String, confirmedPassword: String, completion:  @escaping (_ token: String?, _ error: String?) -> Void) {
        var request = URLRequest(url: AppURL.signUpURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["email" : email, "password" : password, "passwordConfirmed" : confirmedPassword]
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
                    completion(nil, Strings.signupError)
                }
                
            }
            task.resume()
        }
    }
}
