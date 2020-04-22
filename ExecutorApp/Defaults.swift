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
    
    // MARK: - Keys
    
    private static let hasTokenKey = "hasToken"
    
    // MARK: - Set default values
    
    static func setDefault() {
        if defaults.value(forKey: hasTokenKey) == nil {
            defaults.set(false, forKey: hasTokenKey)
        }
    }
}
