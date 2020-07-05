//
//  ImageCropperViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 03.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ImageCropperViewController: UIViewController, UIScrollViewDelegate {
    
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            imageView.image = image
        }
    }
    
    var imageAspectRatio: CGFloat? {
        guard let image = image else { return nil }
        return image.size.width / image.size.height
        
    }
    
    var cropperWidth: CGFloat = 200
    
    var imageCropped: ((UIImage) -> Void)?
    
    let containerView = UIView()
    let imageView = UIImageView()
    let shadowingView = UIView()
    let cropperView = UIView()
    
    var cropperXAnchor: NSLayoutConstraint!
    var cropperYAnchor: NSLayoutConstraint!
    
    var cropperWidthAnchor = NSLayoutConstraint()
    var cropperHeightAnchor = NSLayoutConstraint()
    
    let panRecognizer = UIPanGestureRecognizer()
    let pinchRecognizer =  UIPinchGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.save, style: .done, target: self, action: #selector(crop))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Strings.cancel, style: .plain, target: self, action: #selector(cancel))
        containerView.pinTopAndBottomToLayoutMargins(to: view)
        imageView.pinToEdges(to: containerView)
        imageView.setWidth(equalTo: containerView)
        imageView.setHeight(equalTo: containerView)
        imageView.contentMode = .scaleAspectFit
        
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        shadowingView.pinToEdges(to: containerView)
        
        containerView.addSubview(cropperView)
        cropperView.translatesAutoresizingMaskIntoConstraints = false
        cropperXAnchor = cropperView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0)
        cropperYAnchor = cropperView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0)
        cropperWidthAnchor = cropperView.widthAnchor.constraint(equalToConstant: cropperWidth)
        cropperHeightAnchor = cropperView.heightAnchor.constraint(equalToConstant: cropperWidth)
        cropperXAnchor.isActive = true
        cropperYAnchor.isActive = true
        cropperWidthAnchor.isActive = true
        cropperHeightAnchor.isActive = true
        cropperView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        cropperView.layer.cornerRadius = 5
        cropperView.layer.borderWidth = 2
        cropperView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        cropperView.isUserInteractionEnabled = false
        
        panRecognizer.addTarget(self, action: #selector(drag(sender:)))
        shadowingView.addGestureRecognizer(panRecognizer)
        pinchRecognizer.addTarget(self, action: #selector(zoom(sender:)))
        shadowingView.addGestureRecognizer(pinchRecognizer)
    }
    
    @objc func drag(sender: UIPanGestureRecognizer) {
        guard let width = imageView.image?.fittedWidth(in: imageView),
            let height = imageView.image?.fittedHeight(in: imageView) else { return }
        let maxXShift = width / 2 - cropperView.bounds.width / 2
        let maxYShift = height / 2 - cropperView.bounds.height / 2
        let translation = sender.translation(in: view)
        if cropperXAnchor.constant + translation.x < maxXShift && cropperXAnchor.constant + translation.x > -maxXShift {
            cropperXAnchor.constant += translation.x
        }
        if cropperYAnchor.constant + translation.y < maxYShift && cropperYAnchor.constant + translation.y > -maxYShift {
            cropperYAnchor.constant += translation.y
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func zoom(sender: UIPinchGestureRecognizer) {
        if sender.state == .ended {
            cropperWidth = cropperWidthAnchor.constant
        }
        else {
            let scale = sender.scale
            let newWidth = cropperWidth * scale
            cropperWidthAnchor.constant = newWidth
            cropperHeightAnchor.constant = newWidth
        }
    }
    
    @objc func crop() {
        guard let image = imageView.image, let fixedImage = image.fixedOrientation() else { return }
        let scale = image.size.width / image.fittedWidth(in: imageView)
        let imageOrigin = image.origin(in: imageView)
        let cropperFrame = cropperView.frame
        let diffX = cropperFrame.minX - imageOrigin.x
        let diffY = cropperFrame.minY - imageOrigin.y
        let cropRect = CGRect(x: diffX * scale, y: diffY * scale, width: cropperFrame.width * scale, height: cropperFrame.height * scale)
   
        guard let imageRef: CGImage = fixedImage.cgImage?.cropping(to: cropRect)
        else { return }

        let croppedImage: UIImage = UIImage(cgImage: imageRef)
        if croppedImage.size.width > 400, let resizedImage = croppedImage.resized(toWidth: 400) {
            imageCropped?(resizedImage)
        }
        else {
            imageCropped?(croppedImage)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
}

