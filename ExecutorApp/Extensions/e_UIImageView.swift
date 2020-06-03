//
//  e_UIImageView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data { self?.image = UIImage(data: data) }
            }
        }.resume()
    }
}
