//
//  SettingsTableViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/16/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var avatorView: UIImageView!
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var companyField: UILabel!
    @IBOutlet weak var jobTitleField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var phoneField: UILabel!
    @IBOutlet weak var memberIDField: UILabel!
    
    var myUser = Attendee()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpFields()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("THE Selected section is: \(indexPath.section)")
    }
    
    func setUpFields(){
        myUser = usersDic[globalUsrId]!
        nameField.text = myUser.fullName
        companyField.text = myUser.company
        jobTitleField.text = myUser.jobTitle
        emailField.text = myUser.email
        phoneField.text = myUser.phoneNumber
        memberIDField.text = String(myUser.memberID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Is SettingsPhoneViewController
        if segue.identifier == K.identifiers.changePhoneSegue {
            let _destination = segue.destination as! SettingsPhoneViewController
            _destination.navigationItem.title = K.titles.phoneNumber
            _destination.placeholder = phoneField.text!
            return
        }
        
        // Is not SettingsPhoneViewController
        guard let destination = segue.destination as? SettingsEditViewController
            else {
                print("Error in settings")
                return
        }
        if segue.identifier == K.identifiers.changeNameSegue {
            destination.navigationItem.title = K.titles.name
            destination.placeholder = nameField.text!
        } else if segue.identifier == K.identifiers.changeCompanySegue {
            destination.navigationItem.title = K.titles.company
            destination.placeholder = companyField.text!
        } else if segue.identifier == K.identifiers.changeJobSegue {
            destination.navigationItem.title = K.titles.jobTitle
            destination.placeholder = jobTitleField.text!
        } else if segue.identifier == K.identifiers.changeEmailSegue {
            destination.navigationItem.title = K.titles.email
            destination.placeholder = emailField.text!
        } else if segue.identifier == K.identifiers.changeLinkedInSegue {
            destination.navigationItem.title = K.titles.linkedIn
            destination.placeholder = myUser.linkedIn
        } else if segue.identifier == K.identifiers.changeInstagramSegue {
            destination.navigationItem.title = K.titles.instagram
            destination.placeholder = myUser.instagram
        } else if segue.identifier == K.identifiers.changeFacebookSegue {
            destination.navigationItem.title = K.titles.facebook
            destination.placeholder = myUser.facebook
        } else if segue.identifier == K.identifiers.showMemberIDSegue {
            destination.navigationItem.title = K.titles.memberID
            destination.placeholder = memberIDField.text!
        }
    }
}
