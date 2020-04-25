//
//  SessionTableViewCell.swift
//  HFTP
//
//  Created by Nan Ni on 3/27/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var sessionType: UILabel!
    @IBOutlet weak var sessionLocation: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
