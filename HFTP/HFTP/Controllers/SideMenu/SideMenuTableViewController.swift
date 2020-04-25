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
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 { // Logout
            globalIsLoggedIn = false
            myAgenda = []
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
        
        if(globalIsLoggedIn && !myUser.avator.isEmpty) {
            self.avatorImage.image = fetchData.stringToImage(myUser.avator)
        } else { 
            self.avatorImage.image = UIImage(named: K.imageName.defaultPhoto)
        }
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == K.identifiers.creditsSegue || identifier == K.identifiers.settingsSegue {
            if globalIsLoggedIn == false {
                self.popupAlert(title: "Please Login", message: "", actionTitles: ["OK"], actions: [{action1 in}])
                tableView.reloadData()
                return false
            }
        }
        return true
    }
    
    // MARK: - Data updated
    @IBAction func unwindNotLoggedIn(segue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindLoggedIn(segue: UIStoryboardSegue) {
        myUser = usersDic[globalUsrId]!
        self.updateUserData()
    }
    
    func updateUserData(){
        globalIsLoggedIn = true
        myAgenda = usersDic[globalUsrId]!.sessions
        setUpAvatorAndName()
    }
    
}
