//
//  InfoService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class InfoService {
    
    static var userInfo: UserInfo?
    
    static func getUserInfo(completion: @escaping (UserInfo?, String?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.checkInfoURL)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    completion(nil, error.localizedDescription)
                }
                else if
                    let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let user = jsonDict["user"] as? [String : Any] {
                    print(user)
                    UserInfo.initialize(from: user) { (userInfo) in
                        self.userInfo = userInfo
                        completion(userInfo, nil)
                    }
                }
                else {
                    completion(nil, nil)
                }
            }
        }
        task.resume()
    }
}
