//
//  Attendee.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation

class Attendee: Codable {
    var firstName = "First"
    var lastName = "Last"
    var fullName = ""
    var company = ""
    var jobTitle = ""
    var phoneNumber = ""
    var email = ""
    var memberID : UInt = 0
    
    var credit = 0
    
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
