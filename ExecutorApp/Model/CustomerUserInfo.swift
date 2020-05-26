//
//  CustomerUserInfo.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct CustomerUserInfo {
    var firstName: String
    var lastName: String
    var email: String
    
    func dict() -> [String : Any] {
        var dictionary = [String : Any]()
        dictionary["email"] = self.email
        dictionary["firstName"] = self.firstName
        dictionary["lastName"] = self.lastName
        return dictionary
    }
}

extension CustomerUserInfo: Equatable {
    static func ==(lhs: CustomerUserInfo, rhs: CustomerUserInfo) -> Bool {
        return
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.email == rhs.email
    }
}
