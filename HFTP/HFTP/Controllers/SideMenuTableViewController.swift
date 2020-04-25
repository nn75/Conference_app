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
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var memberID = 2 // Will be updated when user logs in(To be implemented)
    var myUser: Attendee = Attendee()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myUser = usersDic[globalUsrId]!
        setUpAvatorAndName()
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            print("Menu error")
            return
        }
    
    }
    
    // TODO: WHEN NOT LOGGED IN, CAN'T CLICK MY CREDITS AND SETTINGS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            globalIsLoggedIn = false
            setUpAvatorAndName()
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
            if let cell  = tableView.cellForRow(at: indexPath) {
                if (indexPath.row != 0) {
                    cell.contentView.backgroundColor = UIColor(named: K.colors.hftpDarkBlue)
                }
            }
        }

    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell  = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = .clear
        }
    }
        
    func setUpAvatorAndName(){
        self.nameLabel.text = "Hello, " + (globalIsLoggedIn ? myUser.fullName : "Login")
    }
    
    
    // MARK: - Data updated
    @IBAction func unwindFromUserOne(segue: UIStoryboardSegue) {
        globalUsrId = "0"
        myUser = usersDic["0"]!
        self.updateUserData()
    }
    
    @IBAction func unwindFromUserTwo(segue: UIStoryboardSegue) {
        globalUsrId = "1"
        myUser = usersDic["1"]!
        self.updateUserData()
    }
    
    func updateUserData(){
        globalIsLoggedIn = true
        myAgenda = usersDic[globalUsrId]!.sessions
        setUpAvatorAndName()
    }
    
}
