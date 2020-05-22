//
//  ForgotPassApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class ForgotPassApiService {
    
    func requestAuthCode(email: String, completion: @escaping (Bool, String?) -> Void) {
        executeAfterSecond {
            completion(true, nil)
        }
    }
     
    func sendAuthCode(code: String, completion: @escaping (Bool, String?) -> Void) {
        executeAfterSecond {
            completion(true, nil)
        }
    }
    
    func sendPassword(old: String, new: String, completion: @escaping (Bool, String?) -> Void) {
        executeAfterSecond {
            completion(false, "Can't change")
        }
    }
}



func executeAfterSecond(_ block: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: block)
}
