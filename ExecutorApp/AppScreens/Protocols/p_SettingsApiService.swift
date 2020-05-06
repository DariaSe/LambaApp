//
//  p_SettingsApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

protocol SettingsApiService {
    
    // for mock
//    var userInfo: UserInfo { get set }
    
//    func getUserInfo(completion: @escaping (UserInfo?) -> Void)
    func postImage(_ image: UIImage, completion: @escaping (Bool, String?) -> Void)
    func postUserInfo(_ userInfo: UserInfo, completion: @escaping(Bool) -> Void)
    func changePassword(passInfo: PassInfo, completion: @escaping(Bool, String?) -> Void)
}
