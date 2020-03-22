//
//  SpeakerViewController.swift
//  HFTP
//
//  Created by ny38 on 3/18/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SpeakerViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var mySpeaker = Speaker(f: "", l: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = mySpeaker.fullName
        print(mySpeaker.fullName)
        // Do any additional setup after loading the view.
    }

}
