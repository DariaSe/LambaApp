//
//  e_UIView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

// MARK: - Layout helper methods

extension UIView {
    
    func pinToEdges(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
    }
    
    func pinToLayoutMargins(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainToLayoutMargins(of superview: UIView, leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -trailing).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    func constrainToEdges(of superview: UIView, leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    func pinTopAndBottomToLayoutMargins(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainTopAndBottomToLayoutMargins(of superview: UIView, leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    
    func center(in superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(equalTo view: UIView, multiplier: CGFloat = 1) {
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    func setHeight(equalTo view: UIView, multiplier: CGFloat = 1) {
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func setWidth(equalTo constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func setHeight(equalTo constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
}


extension UIView {
    func shake() {
        let midX = self.center.x
        let midY = self.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 5, y: midY)
        animation.toValue = CGPoint(x: midX + 5, y: midY)
        self.layer.add(animation, forKey: "position")
    }
}


extension UIView {
    func maskRoundedCorners(cornerRadius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerRadius: cornerRadius).cgPath
        self.layer.mask = maskLayer
    }
    
    func maskRoundedCorners(corners: UIRectCorner, cornerRadius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.layer.mask = maskLayer
    }
}
