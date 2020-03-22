//
//  Speaker.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation
import UIKit

class Speaker: Codable {
    var firstName = "First"
    var lastName = "Last"
    var fullName = ""
    var avator = ""
    var email = ""
    var description = ""
    
    var linkedIn = ""
    var facebook = ""
    var instagram = ""
    
    // var sessions : [Session] = []

    init(f firstName:String, l lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName + " " + lastName
    }
    
    init(){}
    
}
