//
//  e_Data.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 10.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension Data {

    func write(withName name: String) -> URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        try! write(to: url, options: .atomicWrite)
        return url
    }
}
