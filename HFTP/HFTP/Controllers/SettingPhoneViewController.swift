//
//  SettingPhoneViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import ContactsUI
import Foundation
import PhoneNumberKit
import UIKit

class SettingPhoneViewController: UIViewController, CNContactPickerDelegate{
    
    let phoneNumberKit = PhoneNumberKit()
    
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    
    
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
    }
    
    @objc func saveButtonPressed() {
        self.parseNumber(phoneNumberTextField.text!)
    }
    
    func parseNumber(_ number: String) {
        do {
            let phoneNumber = try phoneNumberKit.parse(number)
            print(phoneNumber.numberString)
        } catch {
            print("Invalid phone number")
        }
    }
    
}
