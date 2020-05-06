//
//  SettingsApiServiceMain.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsApiServiceMain: SettingsApiService {
    
    func postImage(_ image: UIImage, completion: @escaping (Bool, String?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.imageChangeURL)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let jpgData = image.jpegData(compressionQuality: 0.5) else { return }
        let jpgString = jpgData.base64EncodedString()
        let json = ["image" : jpgString]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
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
                    }
                }
            }
            task.resume()
        }
    }
    
    func postUserInfo(_ userInfo: UserInfo, completion: @escaping (Bool) -> Void) {
        
    }
    
    func changePassword(passInfo: PassInfo, completion: @escaping (Bool, String?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.passwordChangeURL)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["oldPassword" : passInfo.oldPass, "password" : passInfo.newPass, "confirm" : passInfo.newPass]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
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
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
