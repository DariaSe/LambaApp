//
//  Print.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 13.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

let formatter = DateFormatter()
func printWithTime(_ object: Any) {
    formatter.dateFormat = "HH:mm:ss.SSS"
    print("\(formatter.string(from: Date())): \(object)")
}
