//
//  AgendaTableViewCell.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

    
    @IBOutlet weak var agendaTitle: UILabel!
    var title = ""
    
    func setUpCell(){
        agendaTitle.text = title
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
