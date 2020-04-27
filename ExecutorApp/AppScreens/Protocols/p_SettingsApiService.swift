//
//  p_SettingsApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 26.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

protocol SettingsApiService {
    
    // for mock
    var userInfo: UserInfo { get set }
    
    func getUserInfo(completion: @escaping (UserInfo?) -> Void)
    func postUserInfo(_ userInfo: UserInfo, completion: @escaping(Bool) -> Void)
}
