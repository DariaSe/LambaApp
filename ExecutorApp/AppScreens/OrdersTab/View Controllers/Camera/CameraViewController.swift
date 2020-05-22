//
//  CameraViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 24.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class CameraViewController: UIViewController {
    
    var urlReceived: ((URL?, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showImagePicker() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            self.remove()
            return
        }
        
        let videoPicker = UIImagePickerController()
        videoPicker.sourceType = .camera
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.allowsEditing = true
        videoPicker.delegate = self
        videoPicker.videoMaximumDuration = 600
        videoPicker.videoQuality = .type640x480
        self.present(videoPicker, animated: true, completion: nil)
    }
    
    func showSaveToLibraryAlert(videoURL: URL) {
        let alert = UIAlertController(title: Strings.saveVideoToLibrary, message: Strings.youMightNeedItLater, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: Strings.save, style: .default) { (_) in
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, nil, nil, nil)
            self.remove()
        }
        let cancelAction = UIAlertAction(title: Strings.doNotSave, style: .destructive) {
            (_) in
            self.remove()
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension CameraViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else {
                self.urlReceived?(nil, Strings.noAccessError)
                return }
        VideoService.encodeVideo(videoUrl: url) { [unowned self] (comprURL) in
            guard let comprURL = comprURL else { self.urlReceived?(url, Strings.noAccessError); return }
            self.urlReceived?(comprURL, nil)
        }
        showSaveToLibraryAlert(videoURL: url)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        urlReceived?(nil, nil)
        self.remove()
    }
}

extension CameraViewController: UINavigationControllerDelegate {
    
}
