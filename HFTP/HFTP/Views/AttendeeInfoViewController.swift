//
//  AttendeeInfoViewController.swift
//  HFTP
//
//  Created by ny38 on 3/18/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class AttendeeInfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var myAttendee = Attendee()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = myAttendee.fullName
    }

}
