//
//  SettingsEditViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SettingsEditViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var placeholder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    func configureUI() {
        textField.text = placeholder == "" ? "None" : placeholder
        
        if navigationItem.title == K.titles.memberID {
            textField.isEnabled = false
            return
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)], for: .normal)
        
        
    }
    
    @objc func saveButtonPressed() {
        if textField.text == "" {
            print("Can't be blank")
            return
        }
        let u = usersDic[globalUsrId]!
        switch navItem.title {
            case K.titles.name:
                u.fullName = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "name", value: textField.text!)
            case K.titles.company:
                u.company = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "company", value: textField.text!)
            case K.titles.jobTitle:
                u.jobTitle = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "title", value: textField.text!)
            case K.titles.email:
                u.email = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "email", value: textField.text!)
            case K.titles.phoneNumber:
                u.phoneNumber = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "phone", value: textField.text!)
            case K.titles.linkedIn:
                u.linkedIn = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "social_media", value: [u.linkedIn,u.facebook,u.instagram])
            case K.titles.facebook:
                u.facebook = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "social_media", value: [u.linkedIn,u.facebook,u.instagram])
            case K.titles.instagram:
                u.instagram = textField.text!
                updateData.updateUser(userId: globalUsrId, fieldName: "social_media", value: [u.linkedIn,u.facebook,u.instagram])
            default:
                break
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
}
