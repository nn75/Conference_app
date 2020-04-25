//
//  Attendee.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation
import UIKit

class Attendee: People {
    var credit = 0
    override init(n name:String, e email: String, c company: String, j jobTitle:String, p phoneNumber: String, id: String, se session: [String], sm socialMedia:[String], av avator: String) {
        super.init(n:name,e:email,c:company,j:jobTitle,p:phoneNumber,id:id, se: session, sm:socialMedia, av: avator)
    }
    
    override init(){
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
