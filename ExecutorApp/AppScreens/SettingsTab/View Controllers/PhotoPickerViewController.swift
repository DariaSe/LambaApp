//
//  PhotoPickerViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 27.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class PhotoPickerViewController: UIViewController {
    
    var imagePicked: ((UIImage) -> Void)?
    var deletePhoto: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: Strings.chooseSource, message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: {
            _ in
            self.remove()
        })
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: Strings.camera, style: .default, handler: { [unowned self] _ in
            imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil) })
            alertController.addAction(cameraAction) }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: Strings.photos, style: .default, handler: { [unowned self] _ in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true,completion: nil) })
            alertController.addAction(photoLibraryAction) }
        
        present(alertController, animated: true, completion: nil)
    }

}

extension PhotoPickerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePicked?(selectedImage)
            dismiss(animated: true, completion: nil)
            self.remove()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.remove()
    }
}

extension PhotoPickerViewController: UINavigationControllerDelegate {
    
}
