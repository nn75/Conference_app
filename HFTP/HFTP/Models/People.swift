//
//  People.swift
//  HFTP
//
//  Created by ny38 on 3/25/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation
import UIKit

var globalMemberID : UInt = 0

class People: Codable {
    var fullName = ""
    var avator = ""
    var email = ""
    var company = ""
    var jobTitle = ""
    var phoneNumber = ""
    var description = ""
    var memberID : String = "0"
    
    var linkedIn = ""
    var facebook = ""
    var instagram = ""
    
    var sessions : [String] = []

    init(n name:String, e email: String, c company: String, j jobTitle:String, p phoneNumber: String, id: String, se session: [String], sm socialMedia:[String], av avator: String) {
        self.fullName = name
        self.email = email
        self.company = company
        self.jobTitle = jobTitle
        self.phoneNumber = phoneNumber
        self.memberID = id
        self.sessions = session
        self.avator = avator
        if socialMedia.count == 3 {
            self.linkedIn = socialMedia[0]
            self.facebook = socialMedia[1]
            self.instagram = socialMedia[2]
            print(socialMedia[0],socialMedia[1],socialMedia[2])
        }
    }
    
    init(n name:String, e email: String, c company: String, j jobTitle:String, p phoneNumber: String, id: String, se session: [String], av avator: String) {
        self.fullName = name
        self.email = email
        self.company = company
        self.jobTitle = jobTitle
        self.phoneNumber = phoneNumber
        self.memberID = id
        self.sessions = session
        self.avator = avator
    }
    
    
    init(){}
    
}
