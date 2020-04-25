//
//  SettingsPhoneViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/18/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import ContactsUI
import Foundation
import PhoneNumberKit
import UIKit

class SettingsPhoneViewController: UIViewController, CNContactPickerDelegate {

    let phoneNumberKit = PhoneNumberKit()
    
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    var placeholder = ""
    var userIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configurePhoneNumberTextField()
        
    }
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)], for: .normal)
    }
    
    func configurePhoneNumberTextField() {
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.withPrefix = true
        self.phoneNumberTextField.withFlag = true
        self.phoneNumberTextField.withExamplePlaceholder = true
        self.phoneNumberTextField.text = placeholder=="" ? "0000000000" : placeholder
    }
    
    @objc func saveButtonPressed() {
        if let number = self.parseNumber(phoneNumberTextField.text!) {
            usersDic[globalUsrId]?.phoneNumber = number
            updateData.updateUser(userId: globalUsrId, fieldName: "phone", value: number)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func parseNumber(_ number: String) -> String? {
        do {
            let phoneNumber = try phoneNumberKit.parse(number)
            print(phoneNumber.numberString)
            return phoneNumber.numberString
        } catch {
            self.popupAlert(title: "Invalid Phone Number", message: "Please try again", actionTitles: ["OK"], actions: [{action in}])
            return nil
        }
    }
}
