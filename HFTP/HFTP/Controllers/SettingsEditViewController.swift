//
//  SettingsEditViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SettingsEditViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)], for: .normal)
    }
    
    @objc func saveButtonPressed() {
        print("Save button pressed")
    }
    
}
