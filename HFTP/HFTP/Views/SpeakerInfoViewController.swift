//
//  SpeakerInfoViewController.swift
//  HFTP
//
//  Created by ny38 on 3/18/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SpeakerInfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var mySpeaker = Speaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = mySpeaker.fullName
        print(mySpeaker.fullName)
    }
    
}
