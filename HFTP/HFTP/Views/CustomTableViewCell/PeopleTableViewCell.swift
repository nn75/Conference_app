//
//  PeopleTableViewCell.swift
//  HFTP
//
//  Created by Nan Ni on 3/25/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatorView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
