//
//  MyAgendaTableViewCell.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class MyAgendaTableViewCell: UITableViewCell {

    @IBOutlet weak var myAgendaTitle: UILabel!
    var title = ""
    
    func setUpCell(){
        myAgendaTitle.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
