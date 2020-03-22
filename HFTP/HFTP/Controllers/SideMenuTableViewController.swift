//
//  SideMenuTableViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/15/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var avatorImage: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
        
    }
    
    func configureUI() {
        avatorImage.round()
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
            if let cell  = tableView.cellForRow(at: indexPath) {
                if (indexPath.row != 0) {
                    cell.contentView.backgroundColor = UIColor(named: "HftpDarkBlue")
                }
            }
        }

    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell  = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = .clear
        }
        
    }
}
