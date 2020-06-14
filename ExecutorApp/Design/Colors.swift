//
//  Colors.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 20.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIColor {
//    public static var tint: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    /// Return the color for Dark Mode
//                    return Colors.osloGray
//                } else {
//                    /// Return the color for Light Mode
//                    return Colors.dataRock
//                }
//            }
//        } else {
//            /// Return a fallback color for iOS 12 and lower.
//            return Colors.dataRock
//        }
//    }()
    static let backgroundColor = UIColor.white
    
    static let tintColor = UIColor(netHex: 0x307BF6)
    
    static let textColor: UIColor = UIColor.black
    static let placeholderTextColor = UIColor(netHex: 0xD1D1D6)
    static let destructiveColor = UIColor(netHex: 0xEB5757)
   
    static let textControlsBackgroundColor = UIColor(netHex: 0xF2F2F7)
    
    static let yellowIndicatorColor = UIColor(netHex: 0xFFA800)
    static let redIndicatorColor = UIColor(netHex: 0xEB5757)
    static let greenIndicatorColor = UIColor(netHex: 0x2ECD51)
    static let uploadIndicatorColor = UIColor.lightGray
    static let moderationIndicatorColor = UIColor(netHex: 0x49A5DE)
    static let disputeIndicatorColor = UIColor.black
    
    static let payButtonBgColor = UIColor(netHex: 0xFF9500)
    
    static let readyToTransferBgColor =  UIColor(netHex: 0xE5F3F4)
    static let unexecutedBgColor = UIColor(netHex: 0xFDF3F1)
}

