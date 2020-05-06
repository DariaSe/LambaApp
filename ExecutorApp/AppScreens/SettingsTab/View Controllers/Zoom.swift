//
//  Zoom.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 03.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let imgPhoto = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imgPhoto
    }
}
