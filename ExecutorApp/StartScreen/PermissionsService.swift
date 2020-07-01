//
//  PermissionsService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit

class PermissionsService {
    static func alertToSettings(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: Strings.settings, style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(settingsAction)
        alert.addAction(okAction)
        return alert
    }
    
    static func requestAccessToMediaLibrary(completion:  @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: completion(true)
        case .denied: completion(false)
        case .restricted: completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized: completion(true)
                case .denied: completion(false)
                case .notDetermined: completion(false)
                case .restricted: completion(false)
                @unknown default:
                    fatalError()
                }
            }
        @unknown default:
            fatalError()
        }
    }
    
    static func requestAccessToCamera(completion:  @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                completion(granted)
            })
        }
    }
    
    static func requestAccessToMic(completion: @escaping (Bool) -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            completion(true)
        case AVAudioSessionRecordPermission.denied:
            completion(false)
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                completion(granted)
            })
        @unknown default:
            break
        }
    }
    
    static func requestVideoRecordingPermission(completion: @escaping (Bool) -> Void) {
        requestAccessToCamera { (granted) in
            if granted {
                requestAccessToMic { (granted) in
                    completion(granted)
                }
            }
            else {
                completion(false)
            }
        }
    }
}
