//
//  e_UIImage.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func getImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            if let data = data {
                completion(UIImage(data: data))
            }
            else {
                completion(nil)
            }
        })
        dataTask.resume()
    }
    
    func jpgDataWithSize(kb: Int) -> Data? {
        guard let originalImageData = self.jpegData(compressionQuality: 1.0) else { return nil }
        let quality: CGFloat = kb.cgFloat / (originalImageData.count.cgFloat / 1024)
        guard let imageData = self.jpegData(compressionQuality: quality) else { return nil }
        return imageData
    }
    
    func resized(for size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resized(for width: CGFloat) -> UIImage {
        let scaleFactor = size.width / width
        let height = size.height / scaleFactor
        let newSize = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

extension UIImage {
    
    var aspectRatio: CGFloat {
        return self.size.width / self.size.height
    }
    
    func fittedHeight(in imageView: UIImageView) -> CGFloat {
        let imageViewAspectRatio = imageView.bounds.width / imageView.bounds.height
        if aspectRatio <= 1 && aspectRatio <= imageViewAspectRatio {
            return imageView.bounds.height
        }
        else {
            return imageView.bounds.width / aspectRatio
        }
    }
    
    func fittedWidth(in imageView: UIImageView) -> CGFloat {
        let imageViewAspectRatio = imageView.bounds.width / imageView.bounds.height
        if aspectRatio <= 1 && aspectRatio <= imageViewAspectRatio {
            return imageView.bounds.height * aspectRatio
        }
        else {
            return imageView.bounds.width
        }
    }
    
    func origin(in imageView: UIImageView) -> CGPoint {
        let originX = (imageView.bounds.width - fittedWidth(in: imageView)) / 2
        let originY = (imageView.bounds.height - fittedHeight(in: imageView)) / 2
        return CGPoint(x: originX, y: originY)
    }
}



extension UIImage {
    
    // Fix image orientaton to portrait up
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage,
            let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return nil }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            break
        }
        
        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
}
