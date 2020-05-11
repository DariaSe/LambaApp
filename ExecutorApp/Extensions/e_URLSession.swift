//
//  e_URLSession.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 08.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension URLSession {
    
    func postRequestDataTask(with request: URLRequest, completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(response)
            if let error = error {
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            }
            if let data = data, let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                print(jsonDict)
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
        return task
    }
}
