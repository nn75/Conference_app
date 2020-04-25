//
//  imagePickerController.swift
//  HFTP
//
//  Created by Kai Wang on 4/12/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
extension SettingsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            let base64String = imageToString(selectedImage)
            avatorView.image = selectedImage
            myUser.avator = base64String
            updateData.updateUser(userId: globalUsrId, fieldName: "avator", value: base64String)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func imageToString(_ image: UIImage) -> String {
        let data: Data = image.jpegData(compressionQuality: 1)!
        let image64Data = data.base64EncodedString(options: .lineLength64Characters)
    
        return image64Data
    }
}
