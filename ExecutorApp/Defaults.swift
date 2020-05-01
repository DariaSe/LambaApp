//
//  Defaults.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class Defaults {
    
    private static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var hasToken: Bool {
        get { defaults.bool(forKey: hasTokenKey) }
        set(newValue) { defaults.set(newValue, forKey: hasTokenKey) }
    }
    
    static var hasPassword: Bool {
        get { defaults.bool(forKey: hasPasswordKey) }
        set(newValue) { defaults.set(newValue, forKey: hasPasswordKey) }
    }
    
    static var token: String? {
        get { defaults.string(forKey: tokenKey) }
        set(newValue) { defaults.set(newValue, forKey: tokenKey) }
    }
    
    // MARK: - Keys
    
    private static let hasTokenKey = "hasToken"
    private static let hasPasswordKey = "hasPassword"
    static let tokenKey = "token"
    
    // MARK: - Set default values
    
    static func setDefault() {
        if defaults.value(forKey: hasTokenKey) == nil {
            defaults.set(false, forKey: hasTokenKey)
        }
        if defaults.value(forKey: hasPasswordKey) == nil {
            defaults.set(false, forKey: hasPasswordKey)
        }
    }
}
