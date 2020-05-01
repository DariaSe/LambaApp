//
//  InfoService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class InfoService {
    
    static func getUserInfo(token: String, completion: @escaping (UserInfo?, Error?) -> Void) {
        var request = URLRequest(url: AppURL.checkInfoURL)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
                completion(nil, error)
            }
            else if
                let data = data,
                let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let user = jsonDict["user"] as? [String : Any] {
                // make userInfo from dict
//                print(user)
                completion(UserInfo.sample(), nil)
            }
            else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
}
