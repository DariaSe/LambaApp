//
//  CustomerSettingsApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class CustomerSettingsApiService {
    
    func postImage(_ image: UIImage, completion: @escaping (Bool, String?) -> Void) {
        guard let jpgData = image.jpegData(compressionQuality: 0.5) else { return }
        let jpgString = jpgData.base64EncodedString()
        let json = ["image" : jpgString]
        guard let request = URLRequest.signedPostRequest(url: AppURL.customerImageChangeURL, jsonDict: json) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func changePassword(passInfo: PassInfo, completion: @escaping (Bool, String?) -> Void) {
        let json = ["oldPassword" : passInfo.oldPass, "password" : passInfo.newPass, "confirm" : passInfo.newPass]
        guard let request = URLRequest.signedPostRequest(url: AppURL.customerPasswordChangeURL, jsonDict: json) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func postUserInfo(_ userInfo: CustomerUserInfo, completion: @escaping (Bool, String?) -> Void) {
        let jsonDict = userInfo.dict()
        guard let request = URLRequest.signedPostRequest(url: AppURL.customerChangeSettingsURL, jsonDict: jsonDict) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func sendEmailChangeAuthCode(completion: @escaping (Bool, String?) -> Void) {
        guard let request = URLRequest.signedPostRequest(url: AppURL.customerChangeEmailURL, jsonDict: nil) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func changeEmail(code: String, email: String, completion: @escaping (Bool, String?) -> Void) {
        let jsonDict = ["code" : code, "newEmail": email]
        guard let request = URLRequest.signedPostRequest(url: AppURL.customerChangeEmailURL, jsonDict: jsonDict) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    
    func logout(completion: @escaping (Bool, String?) -> Void) {
        guard let request = URLRequest.signedPostRequest(url: AppURL.logoutURL, jsonDict: nil) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
}
