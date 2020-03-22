//
//  SettingsTableViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/16/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    private var sectionNames = ["Basic information", "Social"]

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatorView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAvator()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("THE Selected section is: \(indexPath.section)")
    }
    
    func configureAvator() {
        avatorView.round()
        containerView.addShadow(cornerRadius: 25)
    }
}
