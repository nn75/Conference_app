//
//  LoginViewController.swift
//  HFTP
//
//  Created by ny38 on 4/9/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userPicker = UIPickerView()
    
    var selectedUserID = 0
    let pickerData = ["Kai Wang", "Zihui Zheng", "Nibo Ying", "Nan Ni", "Bill Gates"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPicker.delegate = self
        self.userPicker.dataSource = self
        usernameTextField.inputView = userPicker
        usernameTextField.text = pickerData[0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedUserID = row
        usernameTextField.text = pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == K.identifiers.unwindeLoggedInSegue {
            if passwordTextField.text == "hftp2020" { // This is where you set the fake password
                return true
            } else {
                self.popupAlert(title: "Incorrect password", message: "Please try again", actionTitles: ["OK"], actions: [{action in}])
                return false
            }
        }
        return true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        globalUsrId = String(selectedUserID)
        globalIsLoggedIn = true
    }
    
}
