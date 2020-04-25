//
//  AgendaTableViewCell.swift
//  HFTP
//
//  Created by Nan Ni on 3/27/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {


    @IBOutlet weak var agendaDayTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
