//
//  SessionInfoCollectionViewCell.swift
//  HFTP
//
//  Created by Nan Ni on 3/24/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SessionInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var sessionType: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var sessionLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
