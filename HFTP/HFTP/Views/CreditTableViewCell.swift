//
//  SessionTotalTableViewCell.swift
//  HFTP
//
//  Created by Nan Ni on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class CreditTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var sessionCode: PaddingLabel!
    
    @IBOutlet weak var sessionCredit: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
