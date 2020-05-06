//
//  SettingsApiServiceMock.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsApiServiceMock: SettingsApiService {
    func postImage(_ image: UIImage, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    
//    var userInfo = UserInfo.sample()
    
//    func getUserInfo(completion: @escaping (UserInfo?) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            completion(self.userInfo)
//        }
//    }
    
    func postUserInfo(_ userInfo: UserInfo, completion: @escaping (Bool) -> Void) {
       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
    
    func changePassword(passInfo: PassInfo, completion: @escaping (Bool, String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(true, nil)
        }
    }
    
    
}
