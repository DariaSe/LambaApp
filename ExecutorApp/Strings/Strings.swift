//
//  Strings.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct Strings {
    
    // Tab bar
    static let orders = "Orders".localized
    static let finances = "Finances".localized
    static let settings = "Settings".localized
    
    // Login Screen
    static let email = "E-mail".localized
    static let password = "Password".localized
    static let login = "Login".localized
    static let incorrectEmailOrPassword = "Incorrect e-mail or password".localized
    static let loginFailed = "Login failed".localized
    
    // Orders
    static let noOrdersYet = "You have no orders yet".localized
    static let tryAgain = "Try again".localized
    static let openCamera = "Open camera".localized
    static let reject = "Reject".localized
    static let cancel = "Cancel".localized
    static let doYouWantToReject = "Do you want to reject this order?".localized
    static let actionCanNotBeUndone = "This action can not be undone.".localized
    static let done = "Done".localized
    static let youRejected = "You've rejected the order".localized
    static let error = "Failed to connect with server.\n\nCheck your internet connection\nand try again later.".localized
    
    // Camera
    static let saveVideoToLibrary = "Do you want to save this video to your library?".localized
    static let youMightNeedItLater = "You might need it later.".localized
    static let save = "Save".localized
    static let doNotSave = "Do not save".localized
    
    // Finances
    static let readyForTransfer = "Ready for transfer".localized
    static let total = "Total:".localized
    static let unexecutedOrders = "Unexecuted orders".localized
    static let transferAllowed = "Money transfer allowed".localized
    static let transferMoney = "Transfer money".localized
    static let transactionSuccess = "Transaction success".localized
    static let transactionFailed = "Transaction failed".localized
    
    // Settings
    static let settingsChanged = "Settings successfully changed.".localized
    
    // Profile settings
    static let profileSettings = "Profile settings".localized
    static let orderSettings = "Order settings".localized
    static let changePhoto = "Change photo".localized
    static let listHashtags = "List the hashtags divided by space:".localized
    static let hashtagPlaceholder = "#hashtag1 #hashtag2"
    
    // Password
    static let changePassword = "Change password".localized
    static let passReqiurements = "Password should consist of at least 6 characters and contain at least 1 digit.".localized
    static let oldPassword = "Old password".localized
    static let newPassword = "New password".localized
    static let confirmNewPass = "Confirm new password".localized
    static let passChanged = "Password successfully changed".localized
    
    // Logout
    static let logout = "Log out".localized
    static let logoutWarning = "Do you really want to log out?".localized
    static let yes = "Yes".localized
    
    // Orders settings
    static let receiveOrders = "Receive orders".localized
    static let price = "Price".localized
    
    // Photo picker
    static let chooseSource = "Choose source".localized
    static let camera = "Camera".localized
    static let photos = "Photos".localized
    
}
