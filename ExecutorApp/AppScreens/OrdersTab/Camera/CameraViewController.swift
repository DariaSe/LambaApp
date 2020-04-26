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
    
    var urlReceived: ((URL) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showImagePicker() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .camera
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = self
        self.present(mediaUI, animated: true, completion: nil)
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
    
    func generateThumbnail(path: URL) -> String? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            if let imageData = thumbnail.pngData() {
                let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                return strBase64
            }
            else {
                return nil
            }
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}

extension CameraViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else { return }
        urlReceived?(url)
        showSaveToLibraryAlert(videoURL: url)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.remove()
    }
}

extension CameraViewController: UINavigationControllerDelegate {
    
}
