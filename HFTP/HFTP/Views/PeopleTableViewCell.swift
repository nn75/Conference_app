//
//  PeopleTableViewCell.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    var fullName = ""
    
    @IBOutlet weak var cellFullName: UILabel!
    
    func setUpCell(){
        cellFullName.text = fullName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
