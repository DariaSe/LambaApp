//
//  VideoPickerViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 06.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

class VideoPickerViewController: UIViewController {
    
    var urlReceived: ((URL) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func showVideoPicker() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            self.remove()
            return
        }
        
        let videoPicker = UIImagePickerController()
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.delegate = self
        videoPicker.allowsEditing = true
        videoPicker.videoMaximumDuration = 600
        self.present(videoPicker, animated: true, completion: nil)
    }
}

extension VideoPickerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            else { self.remove(); return }
        VideoService.encodeVideo(videoUrl: url) { (comprURL) in
            DispatchQueue.main.async {
                guard let comprURL = comprURL else { self.urlReceived?(url); return }
                self.urlReceived?(comprURL)
            }
        }
        dismiss(animated: true)
        self.remove()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.remove()
    }
}

extension VideoPickerViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.title = Strings.chooseVideo
    }
}

