//
//  Strings.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct Strings {
    
    // Unicode symbols
    static let arrowUp = "\u{2191}"
    static let arrowDown = "\u{2193}"
    
    // Order status
    static let statusDone = "Done".localized
    static let statusActive = "Active".localized
    static let statusYouRejected = "You rejected".localized
    static let statusYouCancelled = "You cancelled".localized
    static let statusRejectedExecutor = "Executor rejected".localized
    static let statusRejectedModerator = "Moderator rejected".localized
    static let statusUploading = "Uploading".localized
    static let statusModeration = "Moderation".localized
    
    // Tab bar
    static let orders = "Orders".localized
    static let finances = "Finances".localized
    static let settings = "Settings".localized
    static let executors = "Executors".localized
    
    // Login Screen
    static let email = "E-mail".localized
    static let password = "Password".localized
    static let login = "Login".localized
    static let incorrectEmailOrPassword = "Incorrect e-mail or password".localized
    static let loginFailed = "Login failed".localized
    static let forgotPassword = "Forgot password?".localized
    static let sendAuthCode = "Send authorization code".localized
    static let enterEmail = "Enter e-mail".localized
    static let haveCode = "I already have code".localized
    static let enterCode = "Enter code from e-mail here".localized
    static let send = "Send".localized
    static let emailNotFound = "E-mail not found".localized
    static let resetPassword = "Reset password".localized
    static let register = "Register".localized
    static let confirmPass = "Confirm password".localized
    static let passNoMatch = "Passwords don't match".localized
    static let signupError = "Couldn't register. Try again later".localized
    
    // Orders
    static let noOrdersYet = "You have no orders yet".localized
    static let tryAgain = "Try again".localized
    static let openCamera = "Open camera".localized
    static let addFromLibrary = "Upload video from library".localized
    static let chooseVideoSource = "Choose video source".localized
    static let durationWarning = "Video duration shouldn't be more than 10 minutes".localized
    static let mediaLibrary = "Media Library".localized
    static let reject = "Reject".localized
    static let cancel = "Cancel".localized
    static let doYouWantToReject = "Do you want to reject this order?".localized
    static let actionCanNotBeUndone = "This action can not be undone.".localized
    static let youRejected = "You've rejected the order".localized
    static let error = "Failed to connect with server.\n\nCheck your internet connection\nand try again later.".localized
    
    // Camera
    static let uploadVideo = "Upload video".localized
    static let saveVideoToLibrary = "Do you want to save this video to your library?".localized
    static let youMightNeedItLater = "You might need it later.".localized
    static let save = "Save".localized
    static let doNotSave = "Do not save".localized
    static let openVideo = "Open video".localized
    static let chooseVideo = "Choose video".localized
    static let videoUploading = "Video is uploading.\nPlease wait".localized
    static let cancelUploading = "Cancel uploading".localized
    static let uploadError = "Couldn't upload video. Try again later".localized
    static let noAccessError = "Failed to access video.".localized
    
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
    static let socialLinksDescription = "(Enter the full links, like\n https://www.instagram.com/your_profile/)".localized
    static let listHashtags = "List the hashtags divided by space:".localized
    static let hashtagPlaceholder = "#hashtag1 #hashtag2"
    static let emptyOrderPriceAlert = "Enter price first".localized
    
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
    static let imageChanged = "Image successfully changed".localized
    
    // Customer
    //Executors Screen
    static let search = "Search".localized
    static let noSearchResults = "No search results".localized
    static let openLink = "Open link in Safari?".localized
    static let invalidURL = "Can't open link".localized
    static let continueString = "Continue".localized
    static let youDoNotPayWarning = "You do not pay for anything yet".localized
    static let options = "Options".localized
    
    // Orders
    static let downloadVideo = "Download video".localized
    static let videoDownloaded = "Video downloaded".localized
    static let goToPhotos = "Go to Photos".localized
    static let invalidFormat = "Invalid file format".localized
    static let cancelOrder = "Cancel order".localized
    static let openDispute = "Open dispute".localized
    static let disputeOnOrder = "dispute on order".localized
    
    // Settings
    static let name = "First name".localized
    static let lastName = "Last name".localized
    static let authCodeSent = "We've sent you an authorization code on your e-mail".localized
//    static let fillAllFields = "Fill all fields".localized
    static let newEmail = "New e-mail".localized
    static let emailChanged = "E-mail successfully changed".localized
    
    // Permissions
    static let accessError = "Access error".localized
    static let allowPhotoAccess = "Allow the app access to photo library in the Settings".localized
}
