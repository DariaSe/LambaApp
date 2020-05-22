//
//  RegistrationApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class RegistrationApiService {
    
    func register(email: String, password: String, confirmedPassword: String, completion:  @escaping (Bool, String?) -> Void) {
        executeAfterSecond {
            completion(false, "Can't register")
        }
    }
}
